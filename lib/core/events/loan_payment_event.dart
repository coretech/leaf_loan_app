import 'package:loan_app/features/loan_history/domain/domain.dart';

abstract class LoanPaymentEvent {}

class LoanPaymentSuccess {
  LoanPaymentSuccess({
    required this.loan,
  });
  LoanData loan;
}
