import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loan_app/core/core.dart';

////Read this for background messaging issues (if any) on android
///https://github.com/FirebaseExtended/flutterfire/issues/2223
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
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
  @override
  Future<void> init() async {
    //FLUTTER LOCAL NOTIFICATIONS
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    //Android notification properties
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      channelDescription:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      styleInformation: DefaultStyleInformation(true, true),
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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        final _currentId = currentId;
        await flutterLocalNotificationsPlugin.show(
          _currentId,
          message.notification?.title,
          message.notification?.body,
          platformChannelSpecifics,
        );
        currentId += 1;
      }
      // if (message.data != null) {
      //   log('onMessage: $message');
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('onMessageOpenedApp: $message');
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
  }
}
