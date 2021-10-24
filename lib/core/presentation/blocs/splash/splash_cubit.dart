import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/onboarding/onboarding.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.onboardingStatusRepo,
    required this.scoringDataCollectionService,
  }) : super(SplashState());

  final OnboardingStatusRepo onboardingStatusRepo;
  final ScoringDataCollectionService scoringDataCollectionService;

  Future<void> initializeApp() async {
    emit(SplashState());
    var onboardingSeen = await onboardingStatusRepo.isOnboardingSeen();
    var recordReferenceNumber =
        await scoringDataCollectionService.scrapeAndSubmitScoringData(
      url: 'url',
    );
    print('record reference number $recordReferenceNumber');
    emit(
      SplashState(credoScraped: true, onboardingSeen: onboardingSeen),
    );
  }
}
