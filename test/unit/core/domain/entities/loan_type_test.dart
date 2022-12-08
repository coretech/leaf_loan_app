import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/domain/entities/entities.dart';

final loanLevel = LoanLevel(
  id: 'id',
  name: 'name',
  description: 'description',
);

void main() {
  test(
    'Given values required to make a LoanType, '
    'When the constructor is called with the values, '
    'Then an instance of LoanType with the values should be created',
    () {
      final loanType = LoanType(
        id: 'id',
        name: 'name',
        description: 'description',
        currencies: [
          LoanCurrency(
            id: '',
            fiatCode: 'KES',
            name: 'KESC',
            minLoanAmount: 100,
            maxLoanAmount: 1000,
          ),
        ],
        minDuration: 1,
        maxDuration: 60,
        interestRate: 1,
        image: 'image',
        purpose: [
          'purpose1',
        ],
        loanLevel: loanLevel,
      );
      expect(loanType, isA<LoanType>());
    },
  );

  test(
    'Given a LoanType instance, '
    'When LoanType.copyWith is called on it with arguments, '
    'Then an instance of LoanType with different values should be returned',
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
        purpose: [
          'purpose1',
        ],
        loanLevel: loanLevel,
      );
      final newLoanType = loanType.copyWith(
        description: 'new description',
      );
      expect(newLoanType, isA<LoanType>());
      expect(newLoanType.description, 'new description');
      expect(newLoanType.id, 'id');
      expect(newLoanType.name, 'name');
      expect(newLoanType.currencies, []);
      expect(newLoanType.minDuration, 1);
      expect(newLoanType.maxDuration, 60);
      expect(newLoanType.interestRate, 1);
      expect(newLoanType.image, 'image');
      expect(newLoanType.purpose, [
        'purpose1',
      ]);
    },
  );

  test(
    'Given two LoanType instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final loanType1 = LoanType(
        id: 'id',
        name: 'name',
        description: 'description',
        currencies: [],
        minDuration: 1,
        maxDuration: 60,
        interestRate: 1,
        image: 'image',
        purpose: [
          'purpose1',
        ],
        loanLevel: loanLevel,
      );
      final loanType2 = LoanType(
        id: 'id',
        name: 'name',
        description: 'description',
        currencies: [],
        minDuration: 1,
        maxDuration: 60,
        interestRate: 1,
        image: 'image',
        purpose: [
          'purpose1',
        ],
        loanLevel: loanLevel,
      );
      expect(loanType1 == loanType2, true);
    },
  );

  test(
    'Given a LoanType instance , '
    'When LoanType.hashCode is called, '
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
        purpose: [
          'purpose1',
        ],
        loanLevel: loanLevel,
      );
      final hashCode = loanType.hashCode;
      expect(hashCode, isA<int>());
    },
  );
}
