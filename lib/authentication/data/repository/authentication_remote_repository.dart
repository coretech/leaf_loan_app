import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/ioc/ioc.dart';

class AuthRepoImplementation extends AuthenticationRepository {
  static const _urlBase = String.fromEnvironment('API_URL');
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();
  final LocalStorage _localStorage = IntegrationIOC.localStorage();
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
        final result = AuthenticationResult.fromMap(response.data);
        await _localStorage.setString(Keys.token, result.token);
        return right(result);
      } else {
        return left(AuthFailure(reason: Reason.invalidCredentials));
      }
    } catch (e) {
      return left(AuthFailure(reason: Reason.serverError));
    }
  }

  @override
  Future<bool> isAuthenticated() {
    return _localStorage.getString(Keys.token).then((token) {
      return token != null;
    });
  }
}