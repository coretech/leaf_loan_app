import 'package:loan_app/features/authentication/ioc/ioc.dart';
import 'package:loan_app/features/onboarding/ioc/ioc.dart';

class FeaturesIOC {
  static Future<void> init() async {
    await AuthIOC.init();
    await OnboardingIOC.init();
  }
}
