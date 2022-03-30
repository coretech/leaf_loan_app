import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/domain/entities/entities.dart';

void main() {
  test(
    'Given values required to make a LoanCurrency, '
    'When the constructor is called with the values, '
    'Then an instance of LoanCurrency with the values should be created',
    () {
      final currency = LoanCurrency(
        id: '',
        fiatCode: 'KES',
        name: 'KESC',
        minLoanAmount: 100,
        maxLoanAmount: 1000,
      );
      expect(currency, isA<LoanCurrency>());
      expect(currency.minLoanAmount, 100);
      expect(currency.maxLoanAmount, 1000);
    },
  );

  test(
    'Given a LoanCurrency instance, '
    'When LoanCurrency.copyWith is called on it with arguments, '
    'Then an instance of LoanCurrency with different values should be returned',
    () {
      final currency = LoanCurrency(
        id: '',
        fiatCode: 'KES',
        name: 'KESC',
        minLoanAmount: 100,
        maxLoanAmount: 1000,
      );
      final newLoanCurrency = currency.copyWith(
        maxLoanAmount: 2000,
        minLoanAmount: 200,
      );
      expect(newLoanCurrency, isA<LoanCurrency>());
      expect(newLoanCurrency.minLoanAmount, 200);
      expect(newLoanCurrency.maxLoanAmount, 2000);
    },
  );

  test(
    'Given two LoanCurrency instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final currency1 = LoanCurrency(
        id: '',
        fiatCode: 'KES',
        name: 'KESC',
        minLoanAmount: 100,
        maxLoanAmount: 1000,
      );
      final currency2 = LoanCurrency(
        id: '',
        fiatCode: 'KES',
        name: 'KESC',
        minLoanAmount: 100,
        maxLoanAmount: 1000,
      );
      expect(currency1 == currency2, true);
    },
  );

  test(
    'Given a LoanCurrency instance , '
    'When LoanCurrency.hashCode is called, '
    'Then an integer value should be returned',
    () {
      final currency = LoanCurrency(
        id: '',
        fiatCode: 'KES',
        name: 'KESC',
        minLoanAmount: 100,
        maxLoanAmount: 1000,
      );
      final hashCode = currency.hashCode;
      expect(hashCode, isA<int>());
    },
  );
}
