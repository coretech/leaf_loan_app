abstract class OnboardingStatusRepo {
  Future<bool> isOnboardingSeen();
  Future<void> updateOnboardingStatus({bool viewed = true});
}
