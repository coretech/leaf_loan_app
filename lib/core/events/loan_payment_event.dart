import 'package:loan_app/features/loan_payment/domain/domain.dart';

abstract class LoanPaymentEvent {}

class LoanPaymentSuccess {
  LoanPaymentSuccess({
    required this.payment,
  });
  Payment payment;
}
