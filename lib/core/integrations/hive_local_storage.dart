import 'package:hive_flutter/hive_flutter.dart';
import 'package:loan_app/core/core.dart';

class HiveLocalStorage implements LocalStorage {
  HiveLocalStorage({
    required this.box,
  });

  late Box box;

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>('preferencesBox');
  }

  static void dispose() {
    Hive.close();
  }

  T? _getValue<T>(dynamic key, {T? defaultValue}) =>
      box.get(key, defaultValue: defaultValue) as T?;

  Future<void> _setValue<T>(dynamic key, T value) => box.put(key, value);

  static LocalStorage getInstance() {
    final _box = Hive.box<dynamic>('preferencesBox');
    final hive = HiveLocalStorage(box: _box);
    return hive;
  }

  @override
  Future<bool?> getBool(String key) async {
    return _getValue<bool>(key);
  }

  @override
  Future<double?> getDouble(String key) async {
    return _getValue<double>(key);
  }

  @override
  Future<int?> getInt(String key) async {
    return _getValue<int>(key);
  }

  @override
  Future<String?> getString(String key) async {
    return _getValue<String>(key);
  }

  @override
  Future<void> setBool(String key, bool value) {
    return _setValue(key, value);
  }

  @override
  Future<void> setDouble(String key, double value) {
    return _setValue(key, value);
  }

  @override
  Future<void> setInt(String key, int value) {
    return _setValue(key, value);
  }

  @override
  Future<void> setString(String key, String value) {
    return _setValue(key, value);
  }

  @override
  Future<void> remove(String key) async {
    await box.delete(key);
  }

  @override
  Future<void> clear() async {
    await box.clear();
  }
}
