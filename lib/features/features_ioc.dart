import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/features/loan_application/ioc/ioc.dart';
import 'package:loan_app/features/loan_history/ioc/ioc.dart';
import 'package:loan_app/features/onboarding/ioc/ioc.dart';
import 'package:loan_app/features/user_profile/ioc/ioc.dart';

class FeaturesIOC {
  static Future<void> init() async {
    await AuthIOC.init();
    await OnboardingIOC.init();
    await UserIOC.init();
    await LoanApplicationIOC.init();
    await LoanHistoryIOC.init();
  }
}
