library loan_type_dto_test;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/data/dtos/currency_dto.dart';
import 'package:loan_app/core/data/dtos/loan_type_dto.dart';
import 'package:loan_app/core/domain/entities/currency_id.dart';
import 'package:loan_app/core/domain/entities/loan_type.dart';

void main() {
  const _currencyMap = {
    'currencyid': null,
    'minloanamount': 100,
    'maxloanamount': 1000,
  };

  const _loanTypeMap = {
    'purpose': [
      'purpose1',
    ],
    '_id': 'id',
    'name': 'name',
    'description': 'description',
    'currencies': [_currencyMap],
    'minduration': 1,
    'maxduration': 60,
    'interestrate': 1,
    'image': 'image',
    'createdAt': '2020-01-01',
    'updatedAt': '2020-01-01',
  };

  test(
    'Given values required to make a LoanTypeDTO, '
    'When the constructor is called with the values, '
    'Then an instance of LoanTypeDTO with the values should be created',
    () {
      final loanTypeDto = LoanTypeDTO(
        id: 'id',
        name: 'name',
        description: 'description',
        currencies: [
          CurrencyDTO(
            minloanamount: 100,
            maxloanamount: 1000,
          ),
        ],
        minduration: 1,
        maxduration: 60,
        interestrate: 1,
        image: 'image',
        createdAt: '2020-01-01',
        updatedAt: '2020-01-01',
        purpose: [
          'purpose1',
        ],
      );
      expect(loanTypeDto, isA<LoanTypeDTO>());
      expect(loanTypeDto.id, 'id');
      expect(loanTypeDto.name, 'name');
      expect(loanTypeDto.description, 'description');
      expect(loanTypeDto.currencies.length, 1);
      expect(loanTypeDto.currencies[0].minloanamount, 100);
      expect(loanTypeDto.currencies[0].maxloanamount, 1000);
      expect(loanTypeDto.minduration, 1);
      expect(loanTypeDto.maxduration, 60);
      expect(loanTypeDto.interestrate, 1);
      expect(loanTypeDto.image, 'image');
      expect(loanTypeDto.createdAt, '2020-01-01');
      expect(loanTypeDto.updatedAt, '2020-01-01');
      expect(loanTypeDto.purpose?.length, 1);
      expect(loanTypeDto.purpose?[0], 'purpose1');
    },
  );

  test(
    'Given a map with valid values to make a LoanTypeDTO, '
    'When LoanTypeDTO.fromMap is called with the map, '
    'Then an instance of LoanTypeDTO should be returned',
    () {
      final loanTypeDto = LoanTypeDTO.fromMap(_loanTypeMap);
      expect(loanTypeDto, isA<LoanTypeDTO>());
      expect(loanTypeDto.id, 'id');
      expect(loanTypeDto.name, 'name');
      expect(loanTypeDto.description, 'description');
      expect(loanTypeDto.currencies.length, 1);
      expect(loanTypeDto.currencies[0].minloanamount, 100);
      expect(loanTypeDto.currencies[0].maxloanamount, 1000);
      expect(loanTypeDto.minduration, 1);
      expect(loanTypeDto.maxduration, 60);
      expect(loanTypeDto.interestrate, 1);
      expect(loanTypeDto.image, 'image');
      expect(loanTypeDto.createdAt, '2020-01-01');
      expect(loanTypeDto.updatedAt, '2020-01-01');
      expect(loanTypeDto.purpose?.length, 1);
      expect(loanTypeDto.purpose?[0], 'purpose1');
    },
  );

  test(
    'Given a JSON with valid values to make a LoanTypeDTO, '
    'When LoanTypeDTO.fromJson is called with the map, '
    'Then an instance of LoanTypeDTO should be returned',
    () {
      final currencyJson = jsonEncode(_loanTypeMap);
      final loanTypeDto = LoanTypeDTO.fromJson(currencyJson);
      expect(loanTypeDto, isA<LoanTypeDTO>());
      expect(loanTypeDto.id, 'id');
      expect(loanTypeDto.name, 'name');
      expect(loanTypeDto.description, 'description');
      expect(loanTypeDto.currencies.length, 1);
      expect(loanTypeDto.currencies[0].minloanamount, 100);
      expect(loanTypeDto.currencies[0].maxloanamount, 1000);
      expect(loanTypeDto.minduration, 1);
      expect(loanTypeDto.maxduration, 60);
      expect(loanTypeDto.interestrate, 1);
      expect(loanTypeDto.image, 'image');
      expect(loanTypeDto.createdAt, '2020-01-01');
      expect(loanTypeDto.updatedAt, '2020-01-01');
      expect(loanTypeDto.purpose?.length, 1);
      expect(loanTypeDto.purpose?[0], 'purpose1');
    },
  );
  test(
    'Given a LoanTypeDTO instance, '
    'When LoanTypeDTO.toEntity is called on it, '
    'Then an instance of LoanType should be returned',
    () {
      final loanTypeDto = LoanTypeDTO.fromMap(_loanTypeMap);
      final loanType = loanTypeDto.toEntity();
      expect(loanType, isA<LoanType>());
      expect(loanType.id, 'id');
      expect(loanType.name, 'name');
      expect(loanType.description, 'description');
      expect(loanType.currencies.length, 1);
      expect(loanType.currencies[0].minLoanAmount, 100);
      expect(loanType.currencies[0].maxLoanAmount, 1000);
      expect(loanType.minDuration, 1);
      expect(loanType.maxDuration, 60);
      expect(loanType.interestRate, 1);
      expect(loanType.image, 'image');
      expect(loanType.createdAt, '2020-01-01');
      expect(loanType.updatedAt, '2020-01-01');
      expect(loanType.purpose?.length, 1);
      expect(loanType.purpose?[0], 'purpose1');
    },
  );

  test(
    'Given a LoanTypeDTO instance, '
    'When LoanTypeDTO.copyWith is called on it with arguments, '
    'Then an instance of LoanTypeDTO with different values should '
    'be returned',
    () {
      final loanTypeDto = LoanTypeDTO.fromMap(_loanTypeMap);
      final newLoanTypeDto = loanTypeDto.copyWith(
        description: 'This is a new description',
        createdAt: '2021-05-15T12:00:00.000Z',
      );
      expect(newLoanTypeDto, isA<LoanTypeDTO>());
      expect(newLoanTypeDto.id, 'id');
      expect(newLoanTypeDto.name, 'name');
      expect(newLoanTypeDto.description, 'This is a new description');
      expect(newLoanTypeDto.currencies.length, 1);
      expect(newLoanTypeDto.currencies[0].minloanamount, 100);
      expect(newLoanTypeDto.currencies[0].maxloanamount, 1000);
      expect(newLoanTypeDto.minduration, 1);
      expect(newLoanTypeDto.maxduration, 60);
      expect(newLoanTypeDto.interestrate, 1);
      expect(newLoanTypeDto.image, 'image');
      expect(newLoanTypeDto.createdAt, '2021-05-15T12:00:00.000Z');
      expect(newLoanTypeDto.updatedAt, '2020-01-01');
      expect(newLoanTypeDto.purpose?.length, 1);
      expect(newLoanTypeDto.purpose?[0], 'purpose1');
    },
  );

  test(
    'Given a LoanTypeDTO instance, '
    'When LoanTypeDTO.toMap is called on it, '
    'Then a map that has all the right values should be returned',
    () {
      final loanTypeDto = LoanTypeDTO.fromMap(_loanTypeMap);
      final loanTypeMap = loanTypeDto.toMap();
      expect(loanTypeMap, isA<Map<String, dynamic>>());
      expect(loanTypeMap, _loanTypeMap);
    },
  );

  test(
    'Given a LoanTypeDTO instance, '
    'When LoanTypeDTO.toJson is called on it, '
    'Then a json string that has all the right values should be returned',
    () {
      final loanTypeDto = LoanTypeDTO.fromMap(_loanTypeMap);
      final currencyJson = loanTypeDto.toJson();
      final expectedJsonValue = jsonEncode(_loanTypeMap);
      expect(currencyJson, expectedJsonValue);
    },
  );

  test(
    'Given two LoanTypeDTO instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final loanTypeDto1 = LoanTypeDTO.fromMap(_loanTypeMap);
      final loanTypeDto2 = LoanTypeDTO.fromMap(_loanTypeMap);
      expect(loanTypeDto1 == loanTypeDto2, true);
    },
  );

  test(
    'Given a LoanTypeDTO instance , '
    'When LoanTypeDTO.hashCode is called, '
    'Then an integer value should be returned',
    () {
      final loanTypeDto = LoanTypeDTO.fromMap(_loanTypeMap);
      final hashCode = loanTypeDto.hashCode;
      expect(hashCode, isA<int>());
    },
  );

  test(
    'Given a LoanTypeDTO instance , '
    'When LoanTypeDTO.toString is called, '
    'Then an a string matching the following format should be returned',
    () {
      final loanTypeDto = LoanTypeDTO.fromMap(_loanTypeMap);
      final loanTypeDtoString = loanTypeDto.toString();
      expect(
        loanTypeDtoString,
        'LoanTypeDTO(purpose: ${loanTypeDto.purpose}, _id: ${loanTypeDto.id}, '
        'name: ${loanTypeDto.name}, description:'
        ' ${loanTypeDto.description}, currencies: ${loanTypeDto.currencies}, '
        'minduration: ${loanTypeDto.minduration}, '
        'maxduration: ${loanTypeDto.maxduration}, interestrate: '
        '${loanTypeDto.interestrate}, image: '
        '${loanTypeDto.image}, createdAt: ${loanTypeDto.createdAt}, '
        'updatedAt: ${loanTypeDto.updatedAt})',
      );
    },
  );
}
