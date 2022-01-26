library currency_dto_test;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/data/dtos/currency_dto.dart';
import 'package:loan_app/core/domain/entities/currency.dart';

void main() {
  const _currencyMap = {
    'currencyid': null,
    'minloanamount': 100,
    'maxloanamount': 1000,
  };

  test(
    'Given values required to make a CurrencyDTO, '
    'When the constructor is called with the values, '
    'Then an instance of CurrencyDTO with the values should be created',
    () {
      final currencyDto = CurrencyDTO(
        minloanamount: 100,
        maxloanamount: 1000,
      );
      expect(currencyDto, isA<CurrencyDTO>());
      expect(currencyDto.currencyid, isNull);
      expect(currencyDto.minloanamount, 100);
      expect(currencyDto.maxloanamount, 1000);
    },
  );

  test(
    'Given a map with valid values to make a CurrencyDTO, '
    'When CurrencyDTO.fromMap is called with the map, '
    'Then an instance of CurrencyDTO should be returned',
    () {
      final currencyDto = CurrencyDTO.fromMap(_currencyMap);
      expect(currencyDto, isA<CurrencyDTO>());
      expect(currencyDto.currencyid, isNull);
      expect(currencyDto.minloanamount, 100);
      expect(currencyDto.maxloanamount, 1000);
    },
  );

  test(
    'Given a JSON with valid values to make a CurrencyDTO, '
    'When CurrencyDTO.fromJson is called with the map, '
    'Then an instance of CurrencyDTO should be returned',
    () {
      final currencyJson = jsonEncode(_currencyMap);
      final currencyDto = CurrencyDTO.fromJson(currencyJson);
      expect(currencyDto, isA<CurrencyDTO>());
      expect(currencyDto.currencyid, isNull);
      expect(currencyDto.minloanamount, 100);
      expect(currencyDto.maxloanamount, 1000);
    },
  );
  test(
    'Given a CurrencyDTO instance, '
    'When CurrencyDTO.toEntity is called on it, '
    'Then an instance of Currency should be returned',
    () {
      final currencyDto = CurrencyDTO.fromMap(_currencyMap);
      final currency = currencyDto.toEntity();
      expect(currency, isA<Currency>());
      expect(currency.currencyId, isNull);
      expect(currency.minLoanAmount, 100);
      expect(currency.maxLoanAmount, 1000);
    },
  );

  test(
    'Given a CurrencyDTO instance, '
    'When CurrencyDTO.copyWith is called on it with arguments, '
    'Then an instance of CurrencyDTO with different values should be returned',
    () {
      final currencyDto = CurrencyDTO.fromMap(_currencyMap);
      final newCurrencyDto = currencyDto.copyWith(
        minloanamount: 200,
        maxloanamount: 2000,
      );
      expect(newCurrencyDto, isA<CurrencyDTO>());
      expect(newCurrencyDto.currencyid, isNull);
      expect(newCurrencyDto.minloanamount, 200);
      expect(newCurrencyDto.maxloanamount, 2000);
    },
  );

  test(
    'Given a CurrencyDTO instance, '
    'When CurrencyDTO.toMap is called on it, '
    'Then a map that has all the right values should be returned',
    () {
      final currencyDto = CurrencyDTO.fromMap(_currencyMap);
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
      final currencyDto = CurrencyDTO.fromMap(_currencyMap);
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
      final currencyDto1 = CurrencyDTO.fromMap(_currencyMap);
      final currencyDto2 = CurrencyDTO.fromMap(_currencyMap);
      expect(currencyDto1 == currencyDto2, true);
    },
  );

  test(
    'Given a CurrencyDTO instance , '
    'When CurrencyDTO.hashCode is called, '
    'Then an integer value should be returned',
    () {
      final currencyDto = CurrencyDTO.fromMap(_currencyMap);
      final hashCode = currencyDto.hashCode;
      expect(hashCode, isA<int>());
    },
  );
  
  test(
    'Given a CurrencyDTO instance , '
    'When CurrencyDTO.toString is called, '
    'Then an a string matching the following format should be returned',
    () {
      final currencyDto = CurrencyDTO.fromMap(_currencyMap);
      final currencyDTOString = currencyDto.toString();
      expect(
        currencyDTOString,
        'CurrencyDTO(currencyid: ${currencyDto.currencyid}, '
        'minloanamount: ${currencyDto.minloanamount}, '
        'maxloanamount: ${currencyDto.maxloanamount})',
      );
    },
  );
}
