import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_payment/domain/domain.dart';

void main() {
  test(
    'Given values required to make an LoanPaymentEvent, '
    'When the constructor is called with the values, '
    'Then an instance of LoanPaymentEvent with the values should be created',
    () {
      final payment = Payment(
        id: 'id',
        interestAmount: 3,
        status: 'status',
        createdAt: '',
        customerId: '',
        paymentAmount: 10,
        principalAmount: 100,
        updatedAt: '',
      );
      final loanPayment = LoanPaymentSuccess(
        payment: payment,
      );
      expect(loanPayment, isA<LoanPaymentSuccess>());
      expect(loanPayment.payment, payment);
    },
  );
}
