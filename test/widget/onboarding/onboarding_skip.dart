import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/app.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/features.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUpAll(() async {
    registerFallbackValue(StackTrace.empty);
    await IntegrationIOC.initMock();
    when(() => IntegrationIOC.localStorage().getString(Keys.token))
        .thenAnswer((_) async => null);
    when(() => IntegrationIOC.localStorage().getString(Keys.language))
        .thenAnswer((_) async => 'en');
    when(() => IntegrationIOC.localStorage().getString(Keys.username))
        .thenAnswer((_) async => null);
    when(
      () => IntegrationIOC.localStorage().setBool(
        Keys.onboardingStatus,
        any(),
      ),
    ).thenAnswer((invocation) async {});
    when(() => IntegrationIOC.analytics.logAppOpen()).thenAnswer(
      (_) async {},
    );
    when(() => IntegrationIOC.analytics.logEvent(any())).thenAnswer(
      (_) async {},
    );
    when(() => IntegrationIOC.logger().log(any())).thenAnswer(
      (_) async {},
    );
    when(() => IntegrationIOC.logger().logError(any(), any())).thenAnswer(
      (invocation) async {},
    );
    when(() => IntegrationIOC.recording.init()).thenAnswer(
      (invocation) async {},
    );
    when(
      () => IntegrationIOC.recording.setUserInfo(
        any(),
      ),
    ).thenAnswer(
      (invocation) async {},
    );
    await FeaturesIOC.init();
    await LocalizationIOC.init();
  });
  testWidgets(
    'Given the user is on the onboarding screen, '
    'When skip is tapped, '
    'Then the user should be redirected to the login screen',
    (WidgetTester tester) async {
      when(() => IntegrationIOC.localStorage().getBool(Keys.onboardingStatus))
          .thenAnswer((_) async => false);
      await tester.pumpWidget(
        App(
          navigatorKey: GlobalKey<NavigatorState>(),
        ),
      );
      await tester.pumpAndSettle(const Duration(seconds: 5));
      final skipButton = find.byKey(const Key('skip_button'));
      await tester.tap(skipButton);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      final welcomeText = find.text('Welcome!');
      expect(welcomeText, findsOneWidget);
    },
  );
}
