library currency_dto_test;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/domain/entities/currency.dart';

void main() {
  const _currencyMap = {
    'currencyId': null,
    'minLoanAmount': 100,
    'maxLoanAmount': 1000,
  };

  test(
    'Given values required to make a CurrencyDTO, '
    'When the constructor is called with the values, '
    'Then an instance of CurrencyDTO with the values should be created',
    () {
      final currencyDto = CurrencyDto(
          minLoanAmount: 100,
          maxLoanAmount: 1000,
          fiatCode: 'KES',
          id: '',
          name: 'KESC');
      expect(currencyDto, isA<CurrencyDto>());
      expect(currencyDto.minLoanAmount, 100);
      expect(currencyDto.maxLoanAmount, 1000);
    },
  );

  test(
    'Given a map with valid values to make a CurrencyDTO, '
    'When CurrencyDTO.fromMap is called with the map, '
    'Then an instance of CurrencyDTO should be returned',
    () {
      final currencyDto = CurrencyDto.fromMap(_currencyMap);
      expect(currencyDto, isA<CurrencyDto>());
      expect(currencyDto.minLoanAmount, 100);
      expect(currencyDto.maxLoanAmount, 1000);
    },
  );

  test(
    'Given a JSON with valid values to make a CurrencyDTO, '
    'When CurrencyDTO.fromJson is called with the map, '
    'Then an instance of CurrencyDTO should be returned',
    () {
      final currencyJson = jsonEncode(_currencyMap);
      final currencyDto = CurrencyDto.fromJson(currencyJson);
      expect(currencyDto, isA<CurrencyDto>());
      expect(currencyDto.minLoanAmount, 100);
      expect(currencyDto.maxLoanAmount, 1000);
    },
  );
  test(
    'Given a CurrencyDTO instance, '
    'When CurrencyDTO.toEntity is called on it, '
    'Then an instance of Currency should be returned',
    () {
      final currencyDto = CurrencyDto.fromMap(_currencyMap);
      final currency = currencyDto.toEntity();
      expect(currency, isA<Currency>());
      expect(currency.minLoanAmount, 100);
      expect(currency.maxLoanAmount, 1000);
    },
  );

  test(
    'Given a CurrencyDTO instance, '
    'When CurrencyDTO.copyWith is called on it with arguments, '
    'Then an instance of CurrencyDTO with different values should be returned',
    () {
      final currencyDto = CurrencyDto.fromMap(_currencyMap);
      final newCurrencyDto = currencyDto.copyWith(
        minLoanAmount: 200,
        maxLoanAmount: 2000,
      );
      expect(newCurrencyDto, isA<CurrencyDto>());
      expect(newCurrencyDto.minLoanAmount, 200);
      expect(newCurrencyDto.maxLoanAmount, 2000);
    },
  );

  test(
    'Given a CurrencyDTO instance, '
    'When CurrencyDTO.toMap is called on it, '
    'Then a map that has all the right values should be returned',
    () {
      final currencyDto = CurrencyDto.fromMap(_currencyMap);
      final currencyMap = currencyDto.toMap();
      expect(currencyMap, isA<Map<String, dynamic>>());
      expect(currencyMap, _currencyMap);
    },
  );

  test(
    'Given a CurrencyDTO instance, '
    'When CurrencyDTO.toJson is called on it, '
    'Then a json string that has all the right values should be returned',
    () {
      final currencyDto = CurrencyDto.fromMap(_currencyMap);
      final currencyJson = currencyDto.toJson();
      final expectedJsonValue = jsonEncode(_currencyMap);
      expect(currencyJson, expectedJsonValue);
    },
  );

  test(
    'Given two CurrencyDTO instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final currencyDto1 = CurrencyDto.fromMap(_currencyMap);
      final currencyDto2 = CurrencyDto.fromMap(_currencyMap);
      expect(currencyDto1 == currencyDto2, true);
    },
  );

  test(
    'Given a CurrencyDTO instance , '
    'When CurrencyDTO.hashCode is called, '
    'Then an integer value should be returned',
    () {
      final currencyDto = CurrencyDto.fromMap(_currencyMap);
      final hashCode = currencyDto.hashCode;
      expect(hashCode, isA<int>());
    },
  );

  test(
    'Given a CurrencyDTO instance , '
    'When CurrencyDTO.toString is called, '
    'Then an a string matching the following format should be returned',
    () {
      final currencyDto = CurrencyDto.fromMap(_currencyMap);
      final currencyDTOString = currencyDto.toString();
      expect(
        currencyDTOString,
        'CurrencyDTO('
        'minLoanAmount: ${currencyDto.minLoanAmount}, '
        'maxLoanAmount: ${currencyDto.maxLoanAmount})',
      );
    },
  );
}
