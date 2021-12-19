abstract class Analytics {
  Future<void> logAppOpen();
  Future<void> logEvent(String name, {Map<String, dynamic>? parameters});
  Future<void> logLogin(String username, String method);
  Future<void> logLogout(String? username);
  Future<void> logScreenView(String name);
  Future<void> logShare({
    required String contentType,
    required String itemId,
    required String method,
  });
  Future<void> setCurrentScreen(String screenName);
}
