import 'package:loan_app/core/ioc/ioc.dart';

class OnboardingAnalytics {
  static void logOnboardingSkipped() {
    IntegrationIOC.analytics.logEvent('onboarding_skipped');
  }
}
