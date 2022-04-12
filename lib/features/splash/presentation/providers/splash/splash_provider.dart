import 'package:flutter/foundation.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/onboarding/ioc/ioc.dart';

class SplashProvider extends ChangeNotifier {
  String errorMessage = '';
  bool loading = true;
  bool authenticated = false;
  bool onboardingSeen = false;

  final _authenticationRepository = AuthIOC.authRepo();

  final _onboardingStatusRepo = OnboardingIOC.onboardingStatusRepo();
  final _updater = IntegrationIOC.updater;

  Future<void> checkForUpdate() async {
    try {
      final updateInfo = await _updater.checkForUpdate();
      if (updateInfo.immediateUpdate) {
        await _updater.performImmediateUpdate();
      }
    } catch (e) {
      errorMessage = e.toString();
    }
  }

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
