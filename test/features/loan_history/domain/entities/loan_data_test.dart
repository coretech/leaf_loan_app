import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/domain/entities/loan_type.dart';
import 'package:loan_app/features/loan_history/domain/entities/loan_data.dart';

void main() {
  test(
    'Given values required to make a LoanData, '
    'When the constructor is called with the values, '
    'Then an instance of LoanData with the values should be created',
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
      expect(loan, isA<LoanData>());
    },
  );

  test(
    'Given a LoanData instance, '
    'When LoanData.copyWith is called on it with arguments, '
    'Then an instance of LoanData with different values should be returned',
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
      final newLoanData = loan.copyWith(
        loanPurpose: 'new purpose',
      );
      expect(newLoanData, isA<LoanData>());
      expect(newLoanData.loanPurpose, 'new purpose');
      expect(newLoanData.loanTypeId, loan.loanTypeId);
      expect(newLoanData.remainingAmount, loan.remainingAmount);
      expect(newLoanData.requestedAmount, loan.requestedAmount);
      expect(newLoanData.status, loan.status);
      expect(newLoanData.totalAmount, loan.totalAmount);
      expect(newLoanData.dueDate, loan.dueDate);
      expect(newLoanData.duration, loan.duration);
      expect(newLoanData.interestAmount, loan.interestAmount);
      expect(newLoanData.requestDate, loan.requestDate);
      expect(newLoanData.customerId, loan.customerId);
      expect(newLoanData.currencyId, loan.currencyId);
      expect(newLoanData.id, loan.id);
      expect(newLoanData.createdAt, loan.createdAt);
      expect(newLoanData.updatedAt, loan.updatedAt);
    },
  );

  test(
    'Given two LoanData instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
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

      final loan1 = LoanData(
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

      final loan2 = LoanData(
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
      expect(loan1 == loan2, true);
    },
  );

  test(
    'Given a LoanData instance , '
    'When LoanData.hashCode is called, '
    'Then an integer value should be returned',
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

      final hashCode = loan.hashCode;
      expect(hashCode, isA<int>());
    },
  );
}
