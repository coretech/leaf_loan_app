import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:loan_app/authentication/domain/repositories/repositories.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/onboarding/domain/repositories/repositories.dart';
import 'package:loan_app/features/onboarding/ioc/ioc.dart';

class SplashProvider extends ChangeNotifier {
  String errorMessage = '';
  bool loading = true;
  bool authenticated = false;
  bool onboardingSeen = false;
  bool scoringCompleted = false;

  final AuthenticationRepository _authenticationRepository = AuthIOC.authRepo();

  final OnboardingStatusRepo _onboardingStatusRepo =
      OnboardingIOC.onboardingStatusRepo();

  final ScoringDataCollectionService _scoringDataCollectionService =
      IntegrationIOC.scoringDataCollectionService();

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
      if (authenticated) {
        final scoringEither =
            await _scoringDataCollectionService.scrapeAndSubmitScoringData(
          url: 'url',
        );
        scoringCompleted = scoringEither.fold(
          (l) {
            errorMessage = 'Scoring failed';
            return false;
          },
          (r) {
            log('Scoring completed, reference: $r');
            return true;
          },
        );
        log('Scoring completed? => $scoringCompleted');
      }
    }

    loading = false;
    notifyListeners();
  }
}
