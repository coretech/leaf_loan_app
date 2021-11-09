import 'package:loan_app/features/authentication/ioc/ioc.dart';
import 'package:loan_app/features/onboarding/ioc/ioc.dart';

class FeaturesIOC {
  static init() async {
    AuthIOC.init();
    OnboardingIOC.init();
  }
}
