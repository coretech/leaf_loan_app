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
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebasePerformance.instance.setPerformanceCollectionEnabled(true);
  await RemoteConfig.instance.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ),
  );
  await RemoteConfig.instance.ensureInitialized();
  await RemoteConfig.instance.fetchAndActivate();
  await IntegrationIOC.init();
  await FeaturesIOC.init();
  await LocalizationIOC.init();

  await runZonedGuarded<Future<void>>(
    () async {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      runApp(const App());
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}
