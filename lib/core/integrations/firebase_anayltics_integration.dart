import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';

class FirebaseAnalyticsIntegration implements Analytics {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> logAppOpen() async {
    await _analytics.logAppOpen();
  }

  @override
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters}) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> logLogin(String username, String method) async {
    await _analytics.logLogin(loginMethod: '$username logged in with $method');
  }

  @override
  Future<void> logLogout(String? username) async {
    await _analytics.logEvent(
      name: 'log_out',
      parameters: {'username': username},
    );
  }

  @override
  Future<void> logScreenView(String name) async {
    await _analytics.logScreenView(screenName: name);
  }

  @override
  Future<void> logShare({
    required String contentType,
    required String itemId,
    required String method,
  }) async {
    await _analytics.logShare(
      contentType: contentType,
      itemId: itemId,
      method: method,
    );
  }

  @override
  Future<void> setCurrentScreen(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
  }
}
