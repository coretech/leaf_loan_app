import 'package:flutter/cupertino.dart';
import 'package:loan_app/features/features.dart';
import 'package:loan_app/features/onboarding/data/ioc/onboarding_ioc.dart';

class OnboardingProvider extends ChangeNotifier {
  final OnboardingStatusRepo _onboardingStatusRepo =
      OnboardingIOC.onboardingStatus();
  bool checked = false;
  bool seen = false;

  Future<void> checkOnboardingStatus() async {
    notifyListeners();
    final onboardingEither = await _onboardingStatusRepo.isOnboardingSeen();
    onboardingEither.fold(
      (l) => seen = false,
      (r) {
        seen = r;
      },
    );
    checked = true;
    notifyListeners();
  }

  Future<void> updateOnboardingStatus([bool viewed = true]) async {
    final onboardingEither =
        await _onboardingStatusRepo.updateOnboardingStatus(viewed: viewed);
    onboardingEither.fold(
      (l) => seen = false,
      (r) {
        seen = true;
      },
    );
    notifyListeners();
  }
}
