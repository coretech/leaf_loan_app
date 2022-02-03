import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/domain/entities/currency.dart';

void main() {
  test(
    'Given values required to make a Currency, '
    'When the constructor is called with the values, '
    'Then an instance of Currency with the values should be created',
    () {
      final currency = Currency(
        currencyId: null,
        minLoanAmount: 100,
        maxLoanAmount: 1000,
      );
      expect(currency, isA<Currency>());
      expect(currency.currencyId, isNull);
      expect(currency.minLoanAmount, 100);
      expect(currency.maxLoanAmount, 1000);
    },
  );

  test(
    'Given a Currency instance, '
    'When Currency.copyWith is called on it with arguments, '
    'Then an instance of Currency with different values should be returned',
    () {
      final currency = Currency(
        currencyId: null,
        minLoanAmount: 100,
        maxLoanAmount: 1000,
      );
      final newCurrency = currency.copyWith(
        maxLoanAmount: 2000,
        minLoanAmount: 200,
      );
      expect(newCurrency, isA<Currency>());
      expect(newCurrency.currencyId, isNull);
      expect(newCurrency.minLoanAmount, 200);
      expect(newCurrency.maxLoanAmount, 2000);
    },
  );

  test(
    'Given two Currency instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final currency1 = Currency(
        currencyId: null,
        minLoanAmount: 100,
        maxLoanAmount: 1000,
      );
      final currency2 = Currency(
        currencyId: null,
        minLoanAmount: 100,
        maxLoanAmount: 1000,
      );
      expect(currency1 == currency2, true);
    },
  );

  test(
    'Given a Currency instance , '
    'When Currency.hashCode is called, '
    'Then an integer value should be returned',
    () {
      final currency = Currency(
        currencyId: null,
        minLoanAmount: 100,
        maxLoanAmount: 1000,
      );
      final hashCode = currency.hashCode;
      expect(hashCode, isA<int>());
    },
  );
}
