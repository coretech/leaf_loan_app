import 'dart:async';

import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/ioc/ioc.dart';

class AuthHelper {
  final LocalStorage _localStorage = IntegrationIOC.localStorage();
  Future<void> clear() async {
    await _localStorage.remove(Keys.token);
    await _localStorage.remove(Keys.userId);
  }

  Future<String?> getToken() async {
    return _localStorage.getString(Keys.token);
  }

  Future<String?> getUserId() async {
    return _localStorage.getString(Keys.userId);
  }

  Future<String?> saveToken(String token) async {
    return _localStorage.getString(Keys.token);//
  }

  Stream<bool> get authenticationStream =>
      _authenticationStreamController.stream;

  final StreamController<bool> _authenticationStreamController =
      StreamController<bool>.broadcast();

  void dispose() {
    _authenticationStreamController.close();
  }

  Future<void> logOut() async {
    await clear();
    _authenticationStreamController.add(true);
  }

  Future<void> processResponse(HttpResponse response) async {
    if (response.statusCode == 401) {
      await logOut();
    }
  }
}
