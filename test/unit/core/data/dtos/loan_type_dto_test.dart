library loan_type_dto_test;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/domain/entities/loan_type.dart';

void main() {
  const _currencyMap = {
    'id': '',
    'fiatCode': '',
    'name': '',
    'minLoanAmount': 100.0,
    'maxLoanAmount': 1000.0,
  };

  const _loanTypeMap = {
    'purpose': [
      'purpose1',
    ],
    'id': 'id',
    'name': 'name',
    'description': 'description',
    'currencies': [_currencyMap],
    'minDuration': 1,
    'maxDuration': 60,
    'interestRate': 1.0,
    'image': 'image',
  };

  test(
    'Given values required to make a LoanTypeDto, '
    'When the constructor is called with the values, '
    'Then an instance of LoanTypeDto with the values should be created',
    () {
      final loanTypeDto = LoanTypeDto(
        id: 'id',
        name: 'name',
        description: 'description',
        currencies: [
          LoanCurrencyDto(
            minLoanAmount: 100,
            maxLoanAmount: 1000,
            fiatCode: 'KES',
            id: '',
            name: 'KESC',
          ),
        ],
        minDuration: 1,
        maxDuration: 60,
        interestRate: 1,
        image: 'image',
        purpose: [
          'purpose1',
        ],
      );
      expect(loanTypeDto, isA<LoanTypeDto>());
      expect(loanTypeDto.id, 'id');
      expect(loanTypeDto.name, 'name');
      expect(loanTypeDto.description, 'description');
      expect(loanTypeDto.currencies.length, 1);
      expect(loanTypeDto.currencies[0].minLoanAmount, 100.0);
      expect(loanTypeDto.currencies[0].maxLoanAmount, 1000.0);
      expect(loanTypeDto.minDuration, 1);
      expect(loanTypeDto.maxDuration, 60);
      expect(loanTypeDto.interestRate, 1.0);
      expect(loanTypeDto.image, 'image');
      expect(loanTypeDto.purpose.length, 1);
      expect(loanTypeDto.purpose[0], 'purpose1');
    },
  );

  test(
    'Given a map with valid values to make a LoanTypeDto, '
    'When LoanTypeDto.fromMap is called with the map, '
    'Then an instance of LoanTypeDto should be returned',
    () {
      final loanTypeDto = LoanTypeDto.fromMap(_loanTypeMap);
      expect(loanTypeDto, isA<LoanTypeDto>());
      expect(loanTypeDto.id, 'id');
      expect(loanTypeDto.name, 'name');
      expect(loanTypeDto.description, 'description');
      expect(loanTypeDto.currencies.length, 1);
      expect(loanTypeDto.currencies[0].minLoanAmount, 100.0);
      expect(loanTypeDto.currencies[0].maxLoanAmount, 1000.0);
      expect(loanTypeDto.minDuration, 1);
      expect(loanTypeDto.maxDuration, 60);
      expect(loanTypeDto.interestRate, 1.0);
      expect(loanTypeDto.image, 'image');
      expect(loanTypeDto.purpose.length, 1);
      expect(loanTypeDto.purpose[0], 'purpose1');
    },
  );

  test(
    'Given a JSON with valid values to make a LoanTypeDto, '
    'When LoanTypeDto.fromJson is called with the map, '
    'Then an instance of LoanTypeDto should be returned',
    () {
      final currencyJson = jsonEncode(_loanTypeMap);
      final loanTypeDto = LoanTypeDto.fromJson(currencyJson);
      expect(loanTypeDto, isA<LoanTypeDto>());
      expect(loanTypeDto.id, 'id');
      expect(loanTypeDto.name, 'name');
      expect(loanTypeDto.description, 'description');
      expect(loanTypeDto.currencies.length, 1);
      expect(loanTypeDto.currencies[0].minLoanAmount, 100.0);
      expect(loanTypeDto.currencies[0].maxLoanAmount, 1000.0);
      expect(loanTypeDto.minDuration, 1);
      expect(loanTypeDto.maxDuration, 60);
      expect(loanTypeDto.interestRate, 1.0);
      expect(loanTypeDto.image, 'image');
      expect(loanTypeDto.purpose.length, 1);
      expect(loanTypeDto.purpose[0], 'purpose1');
    },
  );
  test(
    'Given a LoanTypeDto instance, '
    'When LoanTypeDto.toEntity is called on it, '
    'Then an instance of LoanType should be returned',
    () {
      final loanTypeDto = LoanTypeDto.fromMap(_loanTypeMap);
      final loanType = loanTypeDto.toEntity();
      expect(loanType, isA<LoanType>());
      expect(loanType.id, 'id');
      expect(loanType.name, 'name');
      expect(loanType.description, 'description');
      expect(loanType.currencies.length, 1);
      expect(loanType.currencies[0].minLoanAmount, 100.0);
      expect(loanType.currencies[0].maxLoanAmount, 1000.0);
      expect(loanType.minDuration, 1);
      expect(loanType.maxDuration, 60);
      expect(loanType.interestRate, 1.0);
      expect(loanType.image, 'image');
      expect(loanType.purpose.length, 1);
      expect(loanType.purpose[0], 'purpose1');
    },
  );

  test(
    'Given a LoanTypeDto instance, '
    'When LoanTypeDto.copyWith is called on it with arguments, '
    'Then an instance of LoanTypeDto with different values should '
    'be returned',
    () {
      final loanTypeDto = LoanTypeDto.fromMap(_loanTypeMap);
      final newLoanTypeDto = loanTypeDto.copyWith(
        description: 'This is a new description',
      );
      expect(newLoanTypeDto, isA<LoanTypeDto>());
      expect(newLoanTypeDto.id, 'id');
      expect(newLoanTypeDto.name, 'name');
      expect(newLoanTypeDto.description, 'This is a new description');
      expect(newLoanTypeDto.currencies.length, 1);
      expect(newLoanTypeDto.currencies[0].minLoanAmount, 100.0);
      expect(newLoanTypeDto.currencies[0].maxLoanAmount, 1000.0);
      expect(newLoanTypeDto.minDuration, 1);
      expect(newLoanTypeDto.maxDuration, 60);
      expect(newLoanTypeDto.interestRate, 1.0);
      expect(newLoanTypeDto.image, 'image');
      expect(newLoanTypeDto.purpose.length, 1);
      expect(newLoanTypeDto.purpose[0], 'purpose1');
    },
  );

  test(
    'Given a LoanTypeDto instance, '
    'When LoanTypeDto.toMap is called on it, '
    'Then a map that has all the right values should be returned',
    () {
      final loanTypeDto = LoanTypeDto.fromMap(_loanTypeMap);
      final loanTypeMap = loanTypeDto.toMap();
      expect(loanTypeMap, isA<Map<String, dynamic>>());
      expect(loanTypeMap, _loanTypeMap);
    },
  );

  test(
    'Given a LoanTypeDto instance, '
    'When LoanTypeDto.toJson is called on it, '
    'Then a json string that has all the right values should be returned',
    () {
      final loanTypeDto = LoanTypeDto.fromMap(_loanTypeMap);
      final currencyJson = loanTypeDto.toJson();
      final expectedJsonValue = json.encode(_loanTypeMap);
      expect(currencyJson, expectedJsonValue);
    },
  );

  test(
    'Given two LoanTypeDto instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final loanTypeDto1 = LoanTypeDto.fromMap(_loanTypeMap);
      final loanTypeDto2 = LoanTypeDto.fromMap(_loanTypeMap);
      expect(loanTypeDto1 == loanTypeDto2, true);
    },
  );

  test(
    'Given a LoanTypeDto instance , '
    'When LoanTypeDto.hashCode is called, '
    'Then an integer value should be returned',
    () {
      final loanTypeDto = LoanTypeDto.fromMap(_loanTypeMap);
      final hashCode = loanTypeDto.hashCode;
      expect(hashCode, isA<int>());
    },
  );

  test(
    'Given a LoanTypeDto instance , '
    'When LoanTypeDto.toString is called, '
    'Then an a string matching the following format should be returned',
    () {
      final loanTypeDto = LoanTypeDto.fromMap(_loanTypeMap);
      final loanTypeDtoString = loanTypeDto.toString();
      expect(
        loanTypeDtoString,
        'LoanTypeDto(purpose: ${loanTypeDto.purpose}, id: '
        '${loanTypeDto.id}, name: ${loanTypeDto.name}, description:'
        ' ${loanTypeDto.description}, currencies: ${loanTypeDto.currencies}, '
        'minDuration: ${loanTypeDto.minDuration}, '
        'maxDuration: ${loanTypeDto.maxDuration}, interestRate: '
        '${loanTypeDto.interestRate}, image: image)',
      );
    },
  );
}
