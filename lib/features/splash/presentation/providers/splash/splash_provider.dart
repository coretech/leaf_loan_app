import 'package:flutter/foundation.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/features/onboarding/ioc/ioc.dart';

class SplashProvider extends ChangeNotifier {
  String errorMessage = '';
  bool loading = true;
  bool authenticated = false;
  bool onboardingSeen = false;
  bool scoringCompleted = false;

  final _authenticationRepository = AuthIOC.authRepo();

  final _onboardingStatusRepo = OnboardingIOC.onboardingStatusRepo();

  Future<void> initializeApp() async {
    loading = true;
    notifyListeners();
    final onboardingEither = await _onboardingStatusRepo.isOnboardingSeen();

    onboardingSeen = onboardingEither.fold(
      (l) => false,
      (r) => r,
    );

    if (onboardingSeen) {
      authenticated = await _authenticationRepository.isAuthenticated();
    }

    loading = false;
    notifyListeners();
  }
}
