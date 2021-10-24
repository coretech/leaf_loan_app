import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_app/features/onboarding/onboarding.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.onboardingStatusRepo})
      : super(OnboardingStateInitial());
  final OnboardingStatusRepo onboardingStatusRepo;

  Future<void> checkOnboardingStatus() async {
    emit(OnboardingStateInitial());
    var seen = await onboardingStatusRepo.isOnboardingSeen();
    emit(OnboardingStateChecked(seen: seen));
  }

  Future<void> updateOnboardingStatus({bool seen = true}) async {
    emit(OnboardingStateInitial());
    await onboardingStatusRepo.updateOnboardingStatus(viewed: true);
    emit(OnboardingStateChecked(seen: seen));
  }
}
