import 'package:dartz/dartz.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';

abstract class LoanHistoryRepository {
  Future<Either<LoanHistoryFailure, List<LoanData>>> getLoans();
}

class LoanHistoryFailure {}
