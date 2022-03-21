import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:loan_app/app.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/features_ioc.dart';
import 'package:loan_app/i18n/ioc/ioc.dart';

Future<void> main() async {
  final navigatorKey = GlobalKey<NavigatorState>();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebasePerformance.instance.setPerformanceCollectionEnabled(true);
  await FirebaseRemoteConfig.instance.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ),
  );
  await FirebaseRemoteConfig.instance.ensureInitialized();
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await IntegrationIOC.init();
  await IntegrationIOC.messagingService.init(navigatorKey);
  await FeaturesIOC.init();
  await LocalizationIOC.init();

  await runZonedGuarded<Future<void>>(
    () async {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      runApp(
        App(
          navigatorKey: navigatorKey,
        ),
      );
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}
