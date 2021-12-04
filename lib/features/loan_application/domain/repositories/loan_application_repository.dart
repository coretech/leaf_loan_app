import 'package:dartz/dartz.dart';

abstract class LoanApplicationRepository {
  Future<Either<LoanApplicationFailure, bool>> apply({
    required double amount,
    required String currencyId,
    required int duration,
    required String loanPurpose,
    required String loanTypeId,
    required String password,
  });
}

class LoanApplicationFailure {}
