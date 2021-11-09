import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:loan_app/features/authentication/authentication.dart';

class AuthenticationRemoteRepository extends AuthenticationRepository {
  static const _urlBase = String.fromEnvironment('API_URL');
  @override
  Future<Either<AuthFailure, AuthenticationResult>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          '$_urlBase/userservice/signin',
        ),
        body: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode < 400 && response.statusCode >= 200) {
        return right(AuthenticationResult.fromJson(response.body));
      } else {
        return left(AuthFailure(reason: Reason.invalidCredentials));
      }
    } catch (e) {
      return left(AuthFailure(reason: Reason.serverError));
    }
  }
}
