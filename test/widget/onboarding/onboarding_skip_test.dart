import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/app.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/features.dart';
import 'package:mockito/mockito.dart';

void main() {
  setUpAll(() async {
    await IntegrationIOC.initMock();
    await FeaturesIOC.init();
    when(IntegrationIOC.localStorage().getBool(Keys.onboardingStatus))
        .thenAnswer((realInvocation) => Future.value(false));
    when(IntegrationIOC.localStorage().getString(Keys.token))
        .thenAnswer((realInvocation) => Future.value(null));
  });
  testWidgets(
    'Given the user is on the onboarding screen, '
    'When skip is tapped, '
    'Then the user should be redirected to the login screen',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const App(),
      );
      final skipButton = find.text('Skip');
      await tester.tap(skipButton);
      await tester.pump();
      final welcomeText = find.text('Welcome!');
      expect(welcomeText, findsOneWidget);
    },
  );
}
