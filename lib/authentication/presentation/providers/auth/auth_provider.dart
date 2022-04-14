import 'package:flutter/foundation.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/ioc/ioc.dart';

class AuthProvider extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository = AuthIOC.authRepo();

  bool loading = false;

  bool initialLoad = true;
  String username = '';

  String errorMessage = '';
  void setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }

  String _getMessage(Reason reason) {
    switch (reason) {
      case Reason.userNotFound:
        return 'User not found';
      case Reason.invalidCredentials:
        return 'Invalid credentials';
      case Reason.accountLocked:
        return 'Account locked';
      case Reason.serverError:
        return 'Server error';
    }
  }

  bool loggedIn = false;

  Future<void> loadUsername() async {
    username =
        await IntegrationIOC.localStorage().getString(Keys.username) ?? '';
    notifyListeners();
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    initialLoad = false;
    loading = true;
    setErrorMessage('');
    notifyListeners();
    if (username.isNotEmpty && password.isNotEmpty) {
      final authEither = await _authenticationRepository.login(
        username: username,
        password: password,
      );
      authEither.fold(
        (failure) => setErrorMessage(_getMessage(failure.reason)),
        (success) => loggedIn = true,
      );
    } else {
      setErrorMessage(_getMessage(Reason.invalidCredentials));
    }
    loading = false;
    notifyListeners();
  }
}
