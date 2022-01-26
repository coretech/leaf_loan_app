import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/domain/entities/currency_id.dart';

void main() {
  test(
    'Given values required to make a CurrencyId, '
    'When the constructor is called with the values, '
    'Then an instance of CurrencyId with the values should be created',
    () {
      final currencyId = CurrencyId(
        id: 'some_id',
        name: 'Rwandan Franc',
        fiatCode: 'RWF',
        description: 'Rwandan Franc',
        country: 'Rwanda',
        createdAt: '2019-05-15T12:00:00.000Z',
        updatedAt: '2019-05-15T12:00:00.000Z',
      );
      expect(currencyId, isA<CurrencyId>());
    },
  );

  test(
    'Given a CurrencyId instance, '
    'When CurrencyId.copyWith is called on it with arguments, '
    'Then an instance of CurrencyId with different values should be returned',
    () {
      final currencyId = CurrencyId(
        id: 'some_id',
        name: 'Rwandan Franc',
        fiatCode: 'RWF',
        description: 'Rwandan Franc',
        country: 'Rwanda',
        createdAt: '2019-05-15T12:00:00.000Z',
        updatedAt: '2019-05-15T12:00:00.000Z',
      );
      final newCurrencyId = currencyId.copyWith(
        fiatCode: 'RWFC',
      );
      expect(newCurrencyId, isA<CurrencyId>());
      expect(newCurrencyId.fiatCode, 'RWFC');
      expect(newCurrencyId.id, 'some_id');
      expect(newCurrencyId.name, 'Rwandan Franc');
      expect(newCurrencyId.description, 'Rwandan Franc');
      expect(newCurrencyId.country, 'Rwanda');
      expect(newCurrencyId.createdAt, '2019-05-15T12:00:00.000Z');
      expect(newCurrencyId.updatedAt, '2019-05-15T12:00:00.000Z');
    },
  );

  test(
    'Given two CurrencyId instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final currencyId1 = CurrencyId(
        id: 'some_id',
        name: 'Rwandan Franc',
        fiatCode: 'RWF',
        description: 'Rwandan Franc',
        country: 'Rwanda',
        createdAt: '2019-05-15T12:00:00.000Z',
        updatedAt: '2019-05-15T12:00:00.000Z',
      );
      final currencyId2 = CurrencyId(
        id: 'some_id',
        name: 'Rwandan Franc',
        fiatCode: 'RWF',
        description: 'Rwandan Franc',
        country: 'Rwanda',
        createdAt: '2019-05-15T12:00:00.000Z',
        updatedAt: '2019-05-15T12:00:00.000Z',
      );
      expect(currencyId1 == currencyId2, true);
    },
  );

  test(
    'Given a CurrencyId instance , '
    'When CurrencyId.hashCode is called, '
    'Then an integer value should be returned',
    () {
      final currencyId = CurrencyId(
        id: 'some_id',
        name: 'Rwandan Franc',
        fiatCode: 'RWF',
        description: 'Rwandan Franc',
        country: 'Rwanda',
        createdAt: '2019-05-15T12:00:00.000Z',
        updatedAt: '2019-05-15T12:00:00.000Z',
      );
      final hashCode = currencyId.hashCode;
      expect(hashCode, isA<int>());
    },
  );
}
