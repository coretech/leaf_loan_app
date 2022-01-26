import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/domain/entities/loan_type.dart';
import 'package:loan_app/core/events/loan_payment_event.dart';
import 'package:loan_app/features/loan_history/domain/entities/loan_data.dart';

void main() {
  test(
    'Given values required to make an LoanPaymentEvent, '
    'When the constructor is called with the values, '
    'Then an instance of LoanPaymentEvent with the values should be created',
    () {
      final loanType = LoanType(
        id: 'id',
        name: 'name',
        description: 'description',
        currencies: [],
        minDuration: 1,
        maxDuration: 60,
        interestRate: 1,
        image: 'image',
        createdAt: '2020-01-01',
        updatedAt: '2020-01-01',
        purpose: [
          'purpose1',
        ],
      );
      final loan = LoanData(
        createdAt: '2020-01-01',
        currencyId: null,
        customerId: 'c',
        id: 'id',
        dueDate: 'dueDate',
        duration: 2,
        interestAmount: 3,
        loanPurpose: 'purpose',
        loanTypeId: loanType,
        remainingAmount: 32,
        requestDate: 'requestDate',
        requestedAmount: 23.2,
        status: 'status',
        updatedAt: '2020-01-01',
        totalAmount: 23,
      );
      final loanPayment = LoanPaymentSuccess(
        loan: loan,
      );
      expect(loanPayment, isA<LoanPaymentSuccess>());
      expect(loanPayment.loan, loan);
    },
  );
}
