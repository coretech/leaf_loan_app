import 'package:dartz/dartz.dart';
import 'package:loan_app/core/domain/entities/entities.dart';

abstract class LoanLevelRepository {
  Future<Either<LoanLevelFailure, LoanLevel>> getLoanLevel();
}

class LoanLevelFailure {}
