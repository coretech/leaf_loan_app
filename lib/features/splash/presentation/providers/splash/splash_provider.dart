import 'package:flutter/foundation.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/onboarding/domain/repositories/repositories.dart';
import 'package:loan_app/features/onboarding/ioc/ioc.dart';

class SplashProvider extends ChangeNotifier {
  String errorMessage = '';
  bool loading = true;
  bool onboardingSeen = false;
  bool scoringCompleted = false;

  final OnboardingStatusRepo _onboardingStatusRepo =
      OnboardingIOC.onboardingStatusRepo();
  final ScoringDataCollectionService _scoringDataCollectionService =
      IntegrationIOC.scoringDataCollectionService();
  Future<void> initializeApp() async {
    loading = true;
    notifyListeners();
    var onboardingEither = await _onboardingStatusRepo.isOnboardingSeen();
    var scoringEither =
        await _scoringDataCollectionService.scrapeAndSubmitScoringData(
      url: 'url',
    );
    onboardingSeen = onboardingEither.fold(
      (l) => false,
      (r) => true,
    );
    scoringCompleted = scoringEither.fold(
      (l) {
        errorMessage = 'Scoring failed';
        return false;
      },
      (r) => true,
    );
    loading = false;
    notifyListeners();
  }
}
