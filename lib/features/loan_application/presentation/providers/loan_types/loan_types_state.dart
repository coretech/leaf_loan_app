import 'package:loan_app/core/domain/entities/entities.dart';

abstract class LoanTypesState {}

class LoanTypesInitial extends LoanTypesState {}

class LoanTypesLoading extends LoanTypesState {}

class LoanTypesLoaded extends LoanTypesState {
  LoanTypesLoaded(this.loanTypes);

  final List<LoanType> loanTypes;
}

class LoanTypesError extends LoanTypesState {
  LoanTypesError(this.message);

  final String message;
}
