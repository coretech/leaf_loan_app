import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_history/domain/entities/loan_data.dart';

void main() {
  test(
    'Given values required to make an LoanPaymentEvent, '
    'When the constructor is called with the values, '
    'Then an instance of LoanPaymentEvent with the values should be created',
    () {
      final loan = LoanData(
        id: 'id',
        dueDate: 'dueDate',
        duration: 2,
        interestAmount: 3,
        loanPurpose: 'purpose',
        remainingAmount: 32,
        requestDate: '2020-01-01',
        requestedAmount: 23.2,
        status: 'status',
        totalAmount: 23,
        currency: Currency(
          id: 'id',
          name: 'name',
          fiatCode: 'fiatCode',
        ),
        loanType: 'Personal',
      );
      final loanPayment = LoanPaymentSuccess(
        loan: loan,
      );
      expect(loanPayment, isA<LoanPaymentSuccess>());
      expect(loanPayment.loan, loan);
    },
  );
}
