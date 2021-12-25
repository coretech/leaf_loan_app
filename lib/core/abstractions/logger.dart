abstract class Logger {
  Future<void> log(String message);
  Future<void> logError(dynamic exception, StackTrace stackTrace);
  Future<void> setUserId(String userId);
}
