import 'package:dartz/dartz.dart';

import 'package:loan_app/features/authentication/authentication.dart';

abstract class AuthenticationRepository {
  Future<Either<AuthFailure, AuthenticationResult>> login({
    required String username,
    required String password,
  });
}

class AuthFailure {
  final Reason reason;
  AuthFailure({
    required this.reason,
  });
}

enum Reason {
  accountLocked,
  invalidCredentials,
  serverError,
  userNotFound,
}
