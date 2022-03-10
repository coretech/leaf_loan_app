import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/authentication/data/data.dart';
import 'package:loan_app/authentication/domain/domain.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/keys.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:mocktail/mocktail.dart';

const _token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
    '.eyJpZCI6IjVlZmUwM2U3YWE3MGFhNWVlNDQ0OGFl'
    'ZSIsImZuYW1lIjoiTGVhZiIsImxuYW1lIjoiVGVzdG'
    'luZyIsInVzZXJuYW1lIjoiY3VzdG9tZXIiLCJyb2xlI'
    'jpbInVzZXIiLCJjdXN0b21lciJdLCJzdGF0dXMiOiJhY'
    '3RpdmUiLCJpYXQiOjE2MzYxMDA2OTIsImV4cCI6MTYzN'
    'jExNTA5Mn0.r6fG2XjPIc00ybf4CazhT2aXRg7S-7Tw62'
    'y73bxNnDw';

void main() {
  setUpAll(() async {
    registerFallbackValue(StackTrace.empty);
    await IntegrationIOC.initMock();
    when(() => IntegrationIOC.logger().logError(any(), any())).thenAnswer(
      (invocation) async {},
    );
    when(
      () => IntegrationIOC.localStorage().setString(
        any(),
        any(),
      ),
    ).thenAnswer((invocation) async {});
    when(
      () => IntegrationIOC.localStorage().getString(Keys.deviceToken),
    ).thenAnswer((invocation) async {
      return 'deviceToken';
    });
  });

  test(
    'Given correct user credentials, '
    'When AuthRemoteRepo.login is called with the credentials, '
    'Then an instance of Right<AuthenticationResult> with '
    'token and etc should be returned',
    () async {
      //Setup mocks
      when(
        () => IntegrationIOC.httpHelper().post(
          data: {
            'username': 'username',
            'password': 'correct password',
            'devicetoken': 'deviceToken',
            'model': Platform.operatingSystem,
          },
          url: any(
            named: 'url',
            that: contains('/userservice/signin'),
          ),
        ),
      ).thenAnswer((invocation) async {
        return HttpResponse(
          statusCode: 200,
          data: {
            'status': true,
            'message': 'User logged in successfully',
            'type': 'Bearer',
            'token': _token,
          },
        );
      });

      //Start test
      final authRemoteRepo = AuthRemoteRepo();
      final response = await authRemoteRepo.login(
        username: 'username',
        password: 'correct password',
      );
      expect(response, isA<Right>());
      response.fold(
        (l) {},
        (r) {
          expect(r.token, _token);
          expect(r.status, true);
          expect(r.message, 'User logged in successfully');
          expect(r.type, 'Bearer');
        },
      );
    },
  );

  test(
    'Given wrong user credentials, '
    'When AuthRemoteRepo.login is called with the credentials, '
    'Then an instance of Left with error message',
    () async {
      //Setup mocks
      when(
        () => IntegrationIOC.httpHelper().post(
          data: {
            'username': 'username',
            'password': 'wrong password',
            'devicetoken': 'deviceToken',
            'model': Platform.operatingSystem,
          },
          url: any(
            named: 'url',
            that: contains('/userservice/signin'),
          ),
        ),
      ).thenAnswer((invocation) async {
        return HttpResponse(
          statusCode: 200,
          data: {
            'code': 401,
            'status': false,
            'message': 'Username or Password is incorrect'
          },
        );
      });

      //Start test
      final authRemoteRepo = AuthRemoteRepo();
      final response = await authRemoteRepo.login(
        username: 'username',
        password: 'wrong password',
      );
      expect(response, isA<Left>());
      response.fold(
        (l) {
          expect(l, isA<AuthFailure>());
          expect(l.reason, Reason.serverError);
        },
        (r) {},
      );
    },
  );

  test(
    'Given an authenticated user, '
    'When AuthRemoteRepo.isAuthenticated is called, '
    'Then an a bool with true value should be returned',
    () async {
      //Setup mocks
      when(() => IntegrationIOC.localStorage().getString(Keys.token))
          .thenAnswer((invocation) async {
        return _token;
      });

      //Start test
      final authRemoteRepo = AuthRemoteRepo();
      final status = await authRemoteRepo.isAuthenticated();
      expect(status, isA<bool>());
      expect(status, true);
    },
  );

  test(
    'Given an unauthenticated user, '
    'When AuthRemoteRepo.isAuthenticated is called, '
    'Then an a bool with false value should be returned',
    () async {
      //Setup mocks
      when(() => IntegrationIOC.localStorage().getString(Keys.token))
          .thenAnswer((invocation) async {
        return null;
      });

      //Start test
      final authRemoteRepo = AuthRemoteRepo();
      final status = await authRemoteRepo.isAuthenticated();
      expect(status, isA<bool>());
      expect(status, false);
    },
  );
}
