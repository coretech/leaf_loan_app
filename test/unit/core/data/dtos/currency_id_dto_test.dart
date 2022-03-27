library currency_id_dto_test;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/data/dtos/currency_id_dto_old.dart';
import 'package:loan_app/core/domain/entities/currency_id.dart';

void main() {
  const _currencyIdMap = {
    '_id': 'some_id',
    'name': 'Rwandan Franc',
    'fiatcode': 'RWF',
    'description': 'Rwandan Franc',
    'country': 'Rwanda',
    'createdAt': '2019-05-15T12:00:00.000Z',
    'updatedAt': '2019-05-15T12:00:00.000Z',
  };

  test(
    'Given values required to make a CurrencyIdDto, '
    'When the constructor is called with the values, '
    'Then an instance of CurrencyIdDto with the values should be created',
    () {
      final currencyIdDto = CurrencyIdDtoOld(
        id: 'some_id',
        name: 'Rwandan Franc',
        fiatcode: 'RWF',
        description: 'Rwandan Franc',
        country: 'Rwanda',
        createdAt: '2019-05-15T12:00:00.000Z',
        updatedAt: '2019-05-15T12:00:00.000Z',
      );
      expect(currencyIdDto, isA<CurrencyIdDtoOld>());
      expect(currencyIdDto.id, 'some_id');
      expect(currencyIdDto.name, 'Rwandan Franc');
      expect(currencyIdDto.fiatcode, 'RWF');
      expect(currencyIdDto.description, 'Rwandan Franc');
      expect(currencyIdDto.country, 'Rwanda');
      expect(currencyIdDto.createdAt, '2019-05-15T12:00:00.000Z');
      expect(currencyIdDto.updatedAt, '2019-05-15T12:00:00.000Z');
    },
  );

  test(
    'Given a map with valid values to make a CurrencyIdDto, '
    'When CurrencyIdDto.fromMap is called with the map, '
    'Then an instance of CurrencyIdDto should be returned',
    () {
      final currencyIdDto = CurrencyIdDtoOld.fromMap(_currencyIdMap);
      expect(currencyIdDto, isA<CurrencyIdDtoOld>());
      expect(currencyIdDto.id, 'some_id');
      expect(currencyIdDto.name, 'Rwandan Franc');
      expect(currencyIdDto.fiatcode, 'RWF');
      expect(currencyIdDto.description, 'Rwandan Franc');
      expect(currencyIdDto.country, 'Rwanda');
      expect(currencyIdDto.createdAt, '2019-05-15T12:00:00.000Z');
      expect(currencyIdDto.updatedAt, '2019-05-15T12:00:00.000Z');
    },
  );

  test(
    'Given a JSON with valid values to make a CurrencyIdDto, '
    'When CurrencyIdDto.fromJson is called with the map, '
    'Then an instance of CurrencyIdDto should be returned',
    () {
      final currencyJson = jsonEncode(_currencyIdMap);
      final currencyIdDto = CurrencyIdDtoOld.fromJson(currencyJson);
      expect(currencyIdDto, isA<CurrencyIdDtoOld>());
      expect(currencyIdDto.id, 'some_id');
      expect(currencyIdDto.name, 'Rwandan Franc');
      expect(currencyIdDto.fiatcode, 'RWF');
      expect(currencyIdDto.description, 'Rwandan Franc');
      expect(currencyIdDto.country, 'Rwanda');
      expect(currencyIdDto.createdAt, '2019-05-15T12:00:00.000Z');
      expect(currencyIdDto.updatedAt, '2019-05-15T12:00:00.000Z');
    },
  );
  test(
    'Given a CurrencyIdDto instance, '
    'When CurrencyIdDto.toEntity is called on it, '
    'Then an instance of CurrencyId should be returned',
    () {
      final currencyIdDto = CurrencyIdDtoOld.fromMap(_currencyIdMap);
      final currencyId = currencyIdDto.toEntity();
      expect(currencyId, isA<CurrencyId>());
      expect(currencyId.id, 'some_id');
      expect(currencyId.name, 'Rwandan Franc');
      expect(currencyId.fiatCode, 'RWF');
      expect(currencyId.description, 'Rwandan Franc');
      expect(currencyId.country, 'Rwanda');
      expect(currencyId.createdAt, '2019-05-15T12:00:00.000Z');
      expect(currencyId.updatedAt, '2019-05-15T12:00:00.000Z');
    },
  );

  test(
    'Given a CurrencyIdDto instance, '
    'When CurrencyIdDto.copyWith is called on it with arguments, '
    'Then an instance of CurrencyIdDto with different values should '
    'be returned',
    () {
      final currencyIdDto = CurrencyIdDtoOld.fromMap(_currencyIdMap);
      final newCurrencyIdDto = currencyIdDto.copyWith(
        description: 'This is a new description',
        createdAt: '2021-05-15T12:00:00.000Z',
      );
      expect(newCurrencyIdDto, isA<CurrencyIdDtoOld>());
      expect(newCurrencyIdDto.id, 'some_id');
      expect(newCurrencyIdDto.name, 'Rwandan Franc');
      expect(newCurrencyIdDto.fiatcode, 'RWF');
      expect(newCurrencyIdDto.description, 'This is a new description');
      expect(newCurrencyIdDto.country, 'Rwanda');
      expect(newCurrencyIdDto.createdAt, '2021-05-15T12:00:00.000Z');
      expect(newCurrencyIdDto.updatedAt, '2019-05-15T12:00:00.000Z');
    },
  );

  test(
    'Given a CurrencyIdDto instance, '
    'When CurrencyIdDto.toMap is called on it, '
    'Then a map that has all the right values should be returned',
    () {
      final currencyIdDto = CurrencyIdDtoOld.fromMap(_currencyIdMap);
      final currencyIdMap = currencyIdDto.toMap();
      expect(currencyIdMap, isA<Map<String, dynamic>>());
      expect(currencyIdMap, _currencyIdMap);
    },
  );

  test(
    'Given a CurrencyIdDto instance, '
    'When CurrencyIdDto.toJson is called on it, '
    'Then a json string that has all the right values should be returned',
    () {
      final currencyIdDto = CurrencyIdDtoOld.fromMap(_currencyIdMap);
      final currencyJson = currencyIdDto.toJson();
      final expectedJsonValue = jsonEncode(_currencyIdMap);
      expect(currencyJson, expectedJsonValue);
    },
  );

  test(
    'Given two CurrencyIdDto instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final currencyIdDto1 = CurrencyIdDtoOld.fromMap(_currencyIdMap);
      final currencyIdDto2 = CurrencyIdDtoOld.fromMap(_currencyIdMap);
      expect(currencyIdDto1 == currencyIdDto2, true);
    },
  );

  test(
    'Given a CurrencyIdDto instance , '
    'When CurrencyIdDto.hashCode is called, '
    'Then an integer value should be returned',
    () {
      final currencyIdDto = CurrencyIdDtoOld.fromMap(_currencyIdMap);
      final hashCode = currencyIdDto.hashCode;
      expect(hashCode, isA<int>());
    },
  );

  test(
    'Given a CurrencyIdDto instance , '
    'When CurrencyIdDto.toString is called, '
    'Then an a string matching the following format should be returned',
    () {
      final currencyIdDto = CurrencyIdDtoOld.fromMap(_currencyIdMap);
      final currencyIdDtoString = currencyIdDto.toString();
      expect(
        currencyIdDtoString,
        'Currencyid(_id: ${currencyIdDto.id}, name: ${currencyIdDto.name}, '
        'fiatcode: ${currencyIdDto.fiatcode}, '
        'description: ${currencyIdDto.description}, '
        'country: ${currencyIdDto.country}, createdAt: '
        '${currencyIdDto.createdAt}, '
        'updatedAt: ${currencyIdDto.updatedAt})',
      );
    },
  );
}
