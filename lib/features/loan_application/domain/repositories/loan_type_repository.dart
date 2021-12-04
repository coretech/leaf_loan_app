import 'package:dartz/dartz.dart';
import 'package:loan_app/core/domain/domain.dart';

abstract class LoanTypeRepository {
  Future<Either<LoanTypeError, List<LoanType>>> getLoanTypes();
}

class LoanTypeError {}
