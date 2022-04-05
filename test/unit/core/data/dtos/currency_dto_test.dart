library currency_dto_test;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/domain/domain.dart';

void main() {
  const _currencyMap = {
    'id': '',
    'fiatCode': 'KES',
    'name': 'KESC',
    'minLoanAmount': 100.0,
    'maxLoanAmount': 1000.0,
  };

  test(
    'Given values required to make a LoanCurrencyDto, '
    'When the constructor is called with the values, '
    'Then an instance of LoanCurrencyDto with the values should be created',
    () {
      final currencyDto = LoanCurrencyDto(
        minLoanAmount: 100,
        maxLoanAmount: 1000,
        fiatCode: 'KES',
        id: '',
        name: 'KESC',
      );
      expect(currencyDto, isA<LoanCurrencyDto>());
      expect(currencyDto.minLoanAmount, 100);
      expect(currencyDto.maxLoanAmount, 1000);
    },
  );

  test(
    'Given a map with valid values to make a LoanCurrencyDto, '
    'When LoanCurrencyDto.fromMap is called with the map, '
    'Then an instance of LoanCurrencyDto should be returned',
    () {
      final currencyDto = LoanCurrencyDto.fromMap(_currencyMap);
      expect(currencyDto, isA<LoanCurrencyDto>());
      expect(currencyDto.minLoanAmount, 100);
      expect(currencyDto.maxLoanAmount, 1000);
    },
  );

  test(
    'Given a JSON with valid values to make a LoanCurrencyDto, '
    'When LoanCurrencyDto.fromJson is called with the map, '
    'Then an instance of LoanCurrencyDto should be returned',
    () {
      final currencyJson = jsonEncode(_currencyMap);
      final currencyDto = LoanCurrencyDto.fromJson(currencyJson);
      expect(currencyDto, isA<LoanCurrencyDto>());
      expect(currencyDto.minLoanAmount, 100);
      expect(currencyDto.maxLoanAmount, 1000);
    },
  );
  test(
    'Given a LoanCurrencyDto instance, '
    'When LoanCurrencyDto.toEntity is called on it, '
    'Then an instance of Currency should be returned',
    () {
      final currencyDto = LoanCurrencyDto.fromMap(_currencyMap);
      final currency = currencyDto.toEntity();
      expect(currency, isA<LoanCurrency>());
      expect(currency.minLoanAmount, 100);
      expect(currency.maxLoanAmount, 1000);
    },
  );

  test(
    'Given a LoanCurrencyDto instance, '
    'When LoanCurrencyDto.copyWith is called on it with arguments, '
    'Then an instance of LoanCurrencyDto with different values should '
    'be returned',
    () {
      final currencyDto = LoanCurrencyDto.fromMap(_currencyMap);
      final newLoanCurrencyDto = currencyDto.copyWith(
        minLoanAmount: 200,
        maxLoanAmount: 2000,
      );
      expect(newLoanCurrencyDto, isA<LoanCurrencyDto>());
      expect(newLoanCurrencyDto.minLoanAmount, 200);
      expect(newLoanCurrencyDto.maxLoanAmount, 2000);
    },
  );

  test(
    'Given a LoanCurrencyDto instance, '
    'When LoanCurrencyDto.toMap is called on it, '
    'Then a map that has all the right values should be returned',
    () {
      final currencyDto = LoanCurrencyDto.fromMap(_currencyMap);
      final currencyMap = currencyDto.toMap();
      expect(currencyMap, isA<Map<String, dynamic>>());
      expect(currencyMap, _currencyMap);
    },
  );

  test(
    'Given a LoanCurrencyDto instance, '
    'When LoanCurrencyDto.toJson is called on it, '
    'Then a json string that has all the right values should be returned',
    () {
      final currencyDto = LoanCurrencyDto.fromMap(_currencyMap);
      final currencyJson = currencyDto.toJson();
      final expectedJsonValue = jsonEncode(_currencyMap);
      expect(currencyJson, expectedJsonValue);
    },
  );

  test(
    'Given two LoanCurrencyDto instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final currencyDto1 = LoanCurrencyDto.fromMap(_currencyMap);
      final currencyDto2 = LoanCurrencyDto.fromMap(_currencyMap);
      expect(currencyDto1 == currencyDto2, true);
    },
  );

  test(
    'Given a LoanCurrencyDto instance , '
    'When LoanCurrencyDto.hashCode is called, '
    'Then an integer value should be returned',
    () {
      final currencyDto = LoanCurrencyDto.fromMap(_currencyMap);
      final hashCode = currencyDto.hashCode;
      expect(hashCode, isA<int>());
    },
  );

  test(
    'Given a LoanCurrencyDto instance , '
    'When LoanCurrencyDto.toString is called, '
    'Then an a string matching the following format should be returned',
    () {
      final currencyDto = LoanCurrencyDto.fromMap(_currencyMap);
      final currencyDTOString = currencyDto.toString();
      expect(
        currencyDTOString,
        'LoanCurrencyDto(id: ${currencyDto.id}, fiatCode: '
        '${currencyDto.fiatCode}, name: ${currencyDto.name}, '
        'minLoanAmount: ${currencyDto.minLoanAmount}, '
        'maxLoanAmount: ${currencyDto.maxLoanAmount})',
      );
    },
  );
}
