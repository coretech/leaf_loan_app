import 'package:loan_app/core/domain/domain.dart';

abstract class LoanLevelState {}

class LoanLevelInitialState extends LoanLevelState {}

class LoanLevelLoadingState extends LoanLevelState {}

class LoanLevelLoadedState extends LoanLevelState {
  LoanLevelLoadedState({
    required this.loanLevel,
  });

  LoanLevel loanLevel;
}

class LoanLevelFailureState extends LoanLevelState {
  LoanLevelFailureState({
    this.message = 'Something went wrong while fetching your loan level',
  });

  String message;
}
