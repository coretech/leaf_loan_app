import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:loan_app/features/authentication/authentication.dart';
import 'package:http/http.dart' as http;

class AuthenticationRemoteRepository extends AuthenticationRepository {
  static const _urlBase = String.fromEnvironment('API_URL');
  @override
  Future<Either<AuthFailure, AuthenticationResult>> login({
    required String username,
    required String password,
  }) async {
    try {
      var response = await http.post(
          Uri.parse(
            '$_urlBase/auth/signin',
          ),
          body: {
            'username': username,
            'password': password,
          });
      if (response.statusCode < 400 && response.statusCode >= 200) {
        return right(AuthenticationResult.fromJson(response.body));
      } else {
        print(response.body);
        return left(AuthFailure());
      }
    } catch (e) {
      return left(AuthFailure());
    }
  }
}
