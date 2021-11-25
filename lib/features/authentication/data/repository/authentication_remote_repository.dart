import 'package:dartz/dartz.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/authentication/authentication.dart';

class AuthenticationRemoteRepository extends AuthenticationRepository {
  static const _urlBase = String.fromEnvironment('API_URL');
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();
  @override
  Future<Either<AuthFailure, AuthenticationResult>> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _httpHelper.post(
        data: {
          'username': username,
          'password': password,
        },
        url: '$_urlBase/userservice/signin',
      );
      if (response.statusCode < 400 && response.statusCode >= 200) {
        return right(AuthenticationResult.fromMap(response.data));
      } else {
        return left(AuthFailure(reason: Reason.invalidCredentials));
      }
    } catch (e) {
      return left(AuthFailure(reason: Reason.serverError));
    }
  }
}
