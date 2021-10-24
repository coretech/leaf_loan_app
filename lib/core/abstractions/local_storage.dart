abstract class LocalStorage {
  Future<void> setBool(String key, bool value);
  Future<void> setDouble(String key, double value);
  Future<void> setInt(String key, int value);
  Future<void> setString(String val, String value);

  Future<bool?> getBool(String key);
  Future<double?> getDouble(String key);
  Future<int?> getInt(String key);
  Future<String?> getString(String key);
}
