import 'package:dartz/dartz.dart';
import 'package:loan_app/features/loan_payment/domain/entities/entities.dart';

abstract class LoanPaymentRepo {
  Future<Either<LoanPaymentFailure, Payment>> payLoan({
    required String loanId,
    required double amount,
    required String currencyId,
    required String password,
  });

  Future<Either<LoanPaymentFailure, List<Payment>>> getLoanPayments({
    required String loanId,
  });

  Future<Either<LoanPaymentFailure, List<Payment>>> getUserPayments();

  Future<Either<LoanPaymentFailure, Payment>> getLoanPayment(String paymentId);
}

class LoanPaymentFailure {}
