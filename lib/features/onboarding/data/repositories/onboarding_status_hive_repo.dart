import 'package:loan_app/core/constants/keys.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/features.dart';

class OnboardingStatusHiveRepo implements OnboardingStatusRepo {
  @override
  Future<bool> isOnboardingSeen() async {
    return await IntegrationInjector.localStorage()
            .getBool(Keys.onboardingStatus) ??
        false;
  }

  @override
  Future<void> updateOnboardingStatus({bool viewed = true}) {
    return IntegrationInjector.localStorage()
        .setBool(Keys.onboardingStatus, viewed);
  }
}
