import 'package:dartz/dartz.dart';
import 'package:loan_app/features/loan_application/domain/entities/entities.dart';

abstract class LoanTypeRepository {
  Future<Either<LoanTypeError, List<LoanType>>> getLoanTypes();
}

class LoanTypeError {}
