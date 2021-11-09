import 'package:flutter/foundation.dart';
import 'package:loan_app/features/onboarding/domain/domain.dart';
import 'package:loan_app/features/onboarding/ioc/ioc.dart';

class OnboardingProvider extends ChangeNotifier {
  final OnboardingStatusRepo _onboardingStatusRepo =
      OnboardingIOC.onboardingStatusRepo();
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

  // ignore: avoid_positional_boolean_parameters
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
