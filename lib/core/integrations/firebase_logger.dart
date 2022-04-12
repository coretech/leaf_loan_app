import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';

class FirebaseLogger implements Logger {
  FirebaseLogger() {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
  }

  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  @override
  Future<void> log(String message) async {
    await _crashlytics.log(message);
  }

  @override
  Future<void> logError(dynamic exception, StackTrace stackTrace) async {
    await _crashlytics.recordError(exception, stackTrace);
  }

  @override
  Future<void> setUserId(String userId) async {
    await _crashlytics.setUserIdentifier(userId);
  }
}
