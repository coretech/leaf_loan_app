import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_detail/presentation/screens/screens.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/features/loan_history/ioc/ioc.dart';

////Read this for background messaging issues (if any) on android
///https://github.com/FirebaseExtended/flutterfire/issues/2223
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('on background called $message');
  // await Firebase.initializeApp();
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> savePushToken(String token) async {
  await IntegrationIOC.localStorage().setString(Keys.deviceToken, token);
}

int currentId = 0;

class MessagingIntegration implements MessagingService {
  late GlobalKey<NavigatorState> navigatorKey;
  @override
  Future<void> init(GlobalKey<NavigatorState> navigatorKey) async {
    this.navigatorKey = navigatorKey;

    //FLUTTER LOCAL NOTIFICATIONS
    const initializationSettingsAndroid =
        AndroidInitializationSettings('ic_stat');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _parseDataAndCallOnOpen,
    );

    //Android notification properties
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      channelDescription:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      styleInformation: BigTextStyleInformation(''),
    );

    //iOS notification properties
    const iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentSound: true,
      presentAlert: true,
      presentBadge: true,
    );

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await Firebase.initializeApp();

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    final _firebaseMessaging = FirebaseMessaging.instance;

    await _firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        log('onMessageOpenedApp: $message');
        await onNotificationOpened(message.data);
      },
      onDone: () {
        log('on done called');
      },
      onError: (_, __) {
        log('on error called');
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        final _currentId = currentId;
        await flutterLocalNotificationsPlugin.show(
          _currentId,
          message.notification?.title,
          message.notification?.body,
          platformChannelSpecifics,
          payload: json.encode(message.data),
        );
        currentId += 1;
      }
      await emitNotificationEvent(message.data);
      log('onMessage: $message');
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    final token = await _firebaseMessaging.getToken();
    if (token != null) {
      log('FCM Token: $token', name: 'MessagingIntegration');
      await savePushToken(token);
    }

    _firebaseMessaging.onTokenRefresh.listen((token) async {
      await savePushToken(token);
    });

    await _firebaseMessaging.getInitialMessage();
  }

  void _parseDataAndCallOnOpen(String? payload) {
    if (payload != null) {
      final payloadMap = json.decode(payload);
      onNotificationOpened(payloadMap);
    }
  }

  Future<void> onNotificationOpened(Map<String, dynamic> payload) async {
    final loanType = notificationTypeFromString(payload['type']);
    switch (loanType) {
      case NotificationType.loanStatusUpdate:
      case NotificationType.payment:
        final notificationPayload =
            LoanNotificationPayloadDto.fromMap(payload).toEntity();
        await navigate(notificationPayload);
        break;

      case NotificationType.appUpdate:
      case NotificationType.immediateAppUpdate:
      case NotificationType.navigationWithoutPayload:
        break;
    }
  }

  Future<void> emitNotificationEvent(Map<String, dynamic> payload) async {
    final notificationPayload =
        LoanNotificationPayloadDto.fromMap(payload).toEntity();
    final eventBus = IntegrationIOC.eventBus;
    switch (notificationPayload.type) {
      case NotificationType.loanStatusUpdate:
        eventBus.fire(LoanNotificationEvent(payload: notificationPayload));
        break;
      case NotificationType.payment:
        eventBus.fire(PaymentNotificationEvent(payload: notificationPayload));
        break;
      case NotificationType.appUpdate:
        await IntegrationIOC.updater.startFlexibleUpdate();
        break;
      case NotificationType.immediateAppUpdate:
        await IntegrationIOC.updater.performImmediateUpdate();
        break;
      case NotificationType.navigationWithoutPayload:
        final notificationPayload =
            NotificationPayloadDto.fromMap(payload).toEntity();
        if (routeNames.contains(notificationPayload.path)) {
          await navigatorKey.currentState?.pushNamed(notificationPayload.path);
        }
        break;
    }
  }

  Future<void> navigate(LoanNotificationPayload payload) async {
    switch (payload.type) {
      case NotificationType.loanStatusUpdate:
        await navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) {
              return LoaderScreen<LoanData>(
                onDone: _navigateToLoanDetail,
                loaderProvider: LoaderProvider<LoanData>(
                  loader: () => LoanHistoryIOC.loanHistoryRepo()
                      .getLoanById(payload.loanId),
                )..load(),
              );
            },
          ),
        );
        break;
      case NotificationType.payment:
        await navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) {
              return LoaderScreen<LoanData>(
                onDone: _navigateToLoanTransactions,
                loaderProvider: LoaderProvider<LoanData>(
                  loader: () => LoanHistoryIOC.loanHistoryRepo()
                      .getLoanById(payload.loanId),
                )..load(),
              );
            },
          ),
        );
        break;
      case NotificationType.appUpdate:
      case NotificationType.immediateAppUpdate:
      case NotificationType.navigationWithoutPayload:
        break;
    }
  }

  Future<void> _navigateToLoanDetail(LoanData loan) async {
    final args = LoanDetailScreenAltArgs(
      hasActiveLoan: true,
      loan: loan,
    );
    navigatorKey.currentState?.pop();
    await navigatorKey.currentState?.pushNamed(
      LoanDetailScreenAlt.routeName,
      arguments: args,
    );
  }

  Future<void> _navigateToLoanTransactions(LoanData loan) async {
    navigatorKey.currentState?.pop();
    await navigatorKey.currentState?.pushNamed(
      LoanTransactionsScreen.routeName,
      arguments: loan,
    );
  }
}
