import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/core/constants/keys.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:mocktail/mocktail.dart';

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
  });

  test(
    'Given the local storage with values, '
    'When AuthHelper.clear is called '
    'Then an all values in the local storage should be removed',
    () async {
      //Setup mocks
      String? token = 'not removed';
      String? userId = 'not removed';
      when(
        () => IntegrationIOC.localStorage().remove(
          Keys.token,
        ),
      ).thenAnswer((invocation) async {
        token = null;
      });
      when(
        () => IntegrationIOC.localStorage().remove(
          Keys.userId,
        ),
      ).thenAnswer((invocation) async {
        userId = null;
      });

      //Start test
      final authHelper = AuthHelper();
      await authHelper.clear();
      expect(token, null);
      expect(userId, null);
    },
  );

  test(
    'Given the local storage with token, '
    'When AuthHelper.getToken is called '
    'Then an the token must be returned',
    () async {
      //Setup mocks
      const token = 'token';
      when(
        () => IntegrationIOC.localStorage().getString(
          Keys.token,
        ),
      ).thenAnswer((invocation) async {
        return token;
      });

      //Start test
      final authHelper = AuthHelper();
      final actualToken = await authHelper.getToken();
      expect(actualToken, token);
    },
  );

  test(
    'Given the local storage with userId, '
    'When AuthHelper.getUserId is called '
    'Then an the userId must be returned',
    () async {
      //Setup mocks
      const userId = 'userId';
      when(
        () => IntegrationIOC.localStorage().getString(
          Keys.userId,
        ),
      ).thenAnswer((invocation) async {
        return userId;
      });

      //Start test
      final authHelper = AuthHelper();
      final actualUserId = await authHelper.getUserId();
      expect(actualUserId, userId);
    },
  );
}
