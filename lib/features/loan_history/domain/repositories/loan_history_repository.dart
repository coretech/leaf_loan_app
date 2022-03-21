import 'package:dartz/dartz.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';

abstract class LoanHistoryRepository {
  Future<Either<LoanHistoryFailure, List<LoanData>>> getLoans();
  Future<Either<LoanHistoryFailure, LoanData>> getLoanById(String loanId);
  Future<Either<LoanHistoryFailure, LoanData>> getActiveLoan();
}

enum LoanHistoryFailure {
  noActiveLoan,
  error,
}
