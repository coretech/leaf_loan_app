import 'package:loan_app/features/authentication/authentication.dart';

class AuthenticationRemoteRepository extends AuthenticationRepository {
  @override
  Future<AuthenticationResult> login({
    required String username,
    required String password,
  }) async {
    return AuthenticationResult(
        status: true, message: "message", type: "type", token: "token");
  }
}
