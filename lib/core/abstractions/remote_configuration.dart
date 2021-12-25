abstract class RemoteConfiguration {
  Map<String, dynamic> getAll();
  bool getBool(String key);
  double getDouble(String key);
  int getInt(String key);
  String getString(String key);
}
