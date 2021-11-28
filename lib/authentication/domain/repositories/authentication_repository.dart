import 'package:dartz/dartz.dart';

import 'package:loan_app/authentication/authentication.dart';

abstract class AuthenticationRepository {
  Future<Either<AuthFailure, AuthenticationResult>> login({
    required String username,
    required String password,
  });

  Future<bool> isAuthenticated();
}

class AuthFailure {
  AuthFailure({
    required this.reason,
  });

  final Reason reason;
}

enum Reason {
  accountLocked,
  invalidCredentials,
  serverError,
  userNotFound,
}
