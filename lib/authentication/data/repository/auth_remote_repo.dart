import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/ioc/ioc.dart';

class AuthRemoteRepo extends AuthenticationRepository {
  static const _urlBase = String.fromEnvironment('API_URL');
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();
  final LocalStorage _localStorage = IntegrationIOC.localStorage();
  @override
  Future<Either<AuthFailure, AuthenticationResult>> login({
    required String username,
    required String password,
  }) async {
    try {
      final deviceToken =
          await IntegrationIOC.localStorage().getString(Keys.deviceToken);
      final response = await _httpHelper.post(
        data: {
          'username': username,
          'password': password,
          'devicetoken': deviceToken ,
          'model': Platform.operatingSystem,
        },
        url: '$_urlBase/userservice/signin',
      );
      if (response.statusCode < 400 && response.statusCode >= 200) {
        final result = AuthenticationResult.fromMap(response.data);
        final userMap = JwtDecoder.decode(result.token);
        await _localStorage.setString(Keys.token, result.token);
        await _localStorage.setString(Keys.firstName, userMap['fname']);
        await _localStorage.setString(Keys.username, username);
        await _localStorage.setString(Keys.userId, userMap['id']);
        return right(result);
      } else {
        if (((response.data as Map<String, dynamic>)['message'] as String)
            .contains('locked')) {
          return left(AuthFailure(reason: Reason.accountLocked));
        }
        return left(AuthFailure(reason: Reason.invalidCredentials));
      }
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
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
