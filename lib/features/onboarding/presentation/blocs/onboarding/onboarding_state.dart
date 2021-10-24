abstract class OnboardingState {
  final bool checked;
  final bool seen;
  OnboardingState({
    required this.checked,
    required this.seen,
  });
}

class OnboardingStateInitial extends OnboardingState {
  OnboardingStateInitial() : super(checked: false, seen: false);
}

class OnboardingStateChecked extends OnboardingState {
  OnboardingStateChecked({required bool seen})
      : super(checked: false, seen: seen);
}
