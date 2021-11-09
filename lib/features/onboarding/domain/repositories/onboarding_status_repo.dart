import 'package:dartz/dartz.dart';

abstract class OnboardingStatusRepo {
  Future<Either<OnboardingFailure, bool>> isOnboardingSeen();
  Future<Either<OnboardingFailure, void>> updateOnboardingStatus({
    bool viewed = true,
  });
}

class OnboardingFailure {}
