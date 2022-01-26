library authentication_dto_test;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/authentication/domain/entities/authentication_result.dart';

void main() {
  const _authenticationResultMap = {
    'status': true,
    'message': 'message',
    'type': 'type',
    'token': 'token',
  };

  test(
    'Given values required to make a AuthenticationResult, '
    'When the constructor is called with the values, '
    'Then an instance of AuthenticationResult with the values '
    'should be created',
    () {
      final authenticationResult = AuthenticationResult(
        status: true,
        message: 'message',
        type: 'type',
        token: 'token',
      );
      expect(authenticationResult, isA<AuthenticationResult>());
      expect(authenticationResult.status, true);
      expect(authenticationResult.message, 'message');
      expect(authenticationResult.type, 'type');
      expect(authenticationResult.token, 'token');
    },
  );

  test(
    'Given a map with valid values to make a AuthenticationResult, '
    'When AuthenticationResult.fromMap is called with the map, '
    'Then an instance of AuthenticationResult should be returned',
    () {
      final authenticationResult =
          AuthenticationResult.fromMap(_authenticationResultMap);
      expect(authenticationResult, isA<AuthenticationResult>());
      expect(authenticationResult, isA<AuthenticationResult>());
      expect(authenticationResult.status, true);
      expect(authenticationResult.message, 'message');
      expect(authenticationResult.type, 'type');
      expect(authenticationResult.token, 'token');
    },
  );

  test(
    'Given a JSON with valid values to make a AuthenticationResult, '
    'When AuthenticationResult.fromJson is called with the map, '
    'Then an instance of AuthenticationResult should be returned',
    () {
      final authenticationJson = jsonEncode(_authenticationResultMap);
      final authenticationResult =
          AuthenticationResult.fromJson(authenticationJson);
      expect(authenticationResult, isA<AuthenticationResult>());
      expect(authenticationResult, isA<AuthenticationResult>());
      expect(authenticationResult.status, true);
      expect(authenticationResult.message, 'message');
      expect(authenticationResult.type, 'type');
      expect(authenticationResult.token, 'token');
    },
  );

  test(
    'Given a AuthenticationResult instance, '
    'When AuthenticationResult.copyWith is called on it with arguments, '
    'Then an instance of AuthenticationResult with different values should '
    'be returned',
    () {
      final authenticationResult =
          AuthenticationResult.fromMap(_authenticationResultMap);
      final newAuthenticationResult = authenticationResult.copyWith(
        status: false,
        message: 'new message',
        type: 'new type',
        token: 'new token',
      );
      expect(newAuthenticationResult, isA<AuthenticationResult>());
      expect(newAuthenticationResult.status, false);
      expect(newAuthenticationResult.message, 'new message');
      expect(newAuthenticationResult.type, 'new type');
      expect(newAuthenticationResult.token, 'new token');
    },
  );

  test(
    'Given a AuthenticationResult instance, '
    'When AuthenticationResult.toMap is called on it, '
    'Then a map that has all the right values should be returned',
    () {
      final authenticationResult =
          AuthenticationResult.fromMap(_authenticationResultMap);
      final authenticationMap = authenticationResult.toMap();
      expect(authenticationMap, isA<Map<String, dynamic>>());
      expect(authenticationMap, _authenticationResultMap);
    },
  );

  test(
    'Given a AuthenticationResult instance, '
    'When AuthenticationResult.toJson is called on it, '
    'Then a json string that has all the right values should be returned',
    () {
      final authenticationResult =
          AuthenticationResult.fromMap(_authenticationResultMap);
      final authenticationJson = authenticationResult.toJson();
      final expectedJsonValue = jsonEncode(_authenticationResultMap);
      expect(authenticationJson, expectedJsonValue);
    },
  );

  test(
    'Given two AuthenticationResult instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final authenticationResult1 =
          AuthenticationResult.fromMap(_authenticationResultMap);
      final authenticationResult2 =
          AuthenticationResult.fromMap(_authenticationResultMap);
      expect(authenticationResult1 == authenticationResult2, true);
    },
  );

  test(
    'Given a AuthenticationResult instance , '
    'When AuthenticationResult.hashCode is called, '
    'Then an integer value should be returned',
    () {
      final authenticationResult =
          AuthenticationResult.fromMap(_authenticationResultMap);
      final hashCode = authenticationResult.hashCode;
      expect(hashCode, isA<int>());
    },
  );

  test(
    'Given a AuthenticationResult instance , '
    'When AuthenticationResult.toString is called, '
    'Then an a string matching the following format should be returned',
    () {
      final authenticationResult =
          AuthenticationResult.fromMap(_authenticationResultMap);
      final authenticationString = authenticationResult.toString();
      expect(
        authenticationString,
        'AuthenticationResult(status: ${authenticationResult.status}, '
        'message: ${authenticationResult.message}, '
        'type: ${authenticationResult.type}, '
        'token: ${authenticationResult.token})',
      );
    },
  );
}
