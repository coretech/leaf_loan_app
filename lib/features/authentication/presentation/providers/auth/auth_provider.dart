import 'package:flutter/foundation.dart';
import 'package:loan_app/features/authentication/authentication.dart';

class AuthProvider extends ChangeNotifier {
  final AuthenticationRepository _authenticationRepository = AuthIOC.authRepo();

  bool loading = false;

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
  Future<void> login(
      {required String username, required String password}) async {
    loading = true;
    setErrorMessage('');
    notifyListeners();
    var authEither = await _authenticationRepository.login(
      username: username,
      password: password,
    );
    authEither.fold(
      (failure) => setErrorMessage(_getMessage(failure.reason)),
      (success) => loggedIn = true,
    );
    loading = false;
    notifyListeners();
  }
}
