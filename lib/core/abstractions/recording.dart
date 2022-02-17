abstract class Recording {
  Future<void> init();
  Future<void> setUserInfo(String username);
  void dispose();
}
