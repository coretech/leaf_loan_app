import 'package:dartz/dartz.dart';
import 'package:loan_app/core/constants/keys.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/features.dart';

class OnboardingStatusHiveRepo implements OnboardingStatusRepo {
  @override
  Future<Either<OnboardingFailure, bool>> isOnboardingSeen() async {
    try {
      final seen =
          await IntegrationIOC.localStorage().getBool(Keys.onboardingStatus);
      return right(seen ?? false);
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return left(OnboardingFailure());
    }
  }

  @override
  Future<Either<OnboardingFailure, void>> updateOnboardingStatus({
    bool viewed = true,
  }) async {
    try {
      await IntegrationIOC.localStorage()
          .setBool(Keys.onboardingStatus, viewed);
      return right(null);
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return left(OnboardingFailure());
    }
  }
}
