import 'package:dartz/dartz.dart';
import 'package:loan_app/core/constants/keys.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/features.dart';

class OnboardingStatusHiveRepo implements OnboardingStatusRepo {
  @override
  Future<Either<OnboardingFailure, bool>> isOnboardingSeen() async {
    try {
      var seen = await IntegrationInjector.localStorage()
          .getBool(Keys.onboardingStatus);
      return right(seen ?? false);
    } catch (e) {
      return left(OnboardingFailure());
    }
  }

  @override
  Future<Either<OnboardingFailure, void>> updateOnboardingStatus(
      {bool viewed = true}) async {
    try {
      await IntegrationInjector.localStorage()
          .setBool(Keys.onboardingStatus, viewed);
      return right(null);
    } catch (e) {
      return left(OnboardingFailure());
    }
  }
}
