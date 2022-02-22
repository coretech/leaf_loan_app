import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';

class RemoteConfigIntegration implements RemoteConfiguration {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  @override
  Map<String, dynamic> getAll() {
    return _remoteConfig.getAll();
  }

  @override
  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  @override
  double getDouble(String key) {
    return _remoteConfig.getDouble(key);
  }

  @override
  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  @override
  String getString(String key) {
    return _remoteConfig.getString(key);
  }
}
