import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_history/domain/entities/loan_data.dart';

void main() {
  test(
    'Given values required to make a LoanData, '
    'When the constructor is called with the values, '
    'Then an instance of LoanData with the values should be created',
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
      expect(loan, isA<LoanData>());
    },
  );

  test(
    'Given a LoanData instance, '
    'When LoanData.copyWith is called on it with arguments, '
    'Then an instance of LoanData with different values should be returned',
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
      final newLoanData = loan.copyWith(
        loanPurpose: 'new purpose',
      );
      expect(newLoanData, isA<LoanData>());
      expect(newLoanData.loanPurpose, 'new purpose');
      expect(newLoanData.loanType, loan.loanType);
      expect(newLoanData.remainingAmount, loan.remainingAmount);
      expect(newLoanData.requestedAmount, loan.requestedAmount);
      expect(newLoanData.status, loan.status);
      expect(newLoanData.totalAmount, loan.totalAmount);
      expect(newLoanData.dueDate, loan.dueDate);
      expect(newLoanData.duration, loan.duration);
      expect(newLoanData.interestAmount, loan.interestAmount);
      expect(newLoanData.requestDate, loan.requestDate);
      expect(newLoanData.currency, loan.currency);
      expect(newLoanData.id, loan.id);
    },
  );

  test(
    'Given two LoanData instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final loan1 = LoanData(
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

      final loan2 = LoanData(
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
      expect(loan1 == loan2, true);
    },
  );

  test(
    'Given a LoanData instance , '
    'When LoanData.hashCode is called, '
    'Then an integer value should be returned',
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

      final hashCode = loan.hashCode;
      expect(hashCode, isA<int>());
    },
  );
}
