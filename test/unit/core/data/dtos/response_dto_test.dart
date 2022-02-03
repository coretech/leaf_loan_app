library response_dto_test;

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/data/dtos/response_dto.dart';

void main() {
  const _responseMap = {
    'code': 200,
    'status': true,
    'message': 'Success',
    'data': {
      'id': '1',
    },
  };

  test(
    'Given values required to make a ResponseDto, '
    'When the constructor is called with the values, '
    'Then an instance of ResponseDto with the values should be created',
    () {
      final responseDto = ResponseDto(
        status: true,
        message: 'Success',
        data: {
          'id': '1',
        },
        code: 200,
      );
      expect(responseDto, isA<ResponseDto>());
      expect(responseDto.status, true);
      expect(responseDto.message, 'Success');
      expect(responseDto.data, {
        'id': '1',
      });
      expect(responseDto.code, 200);
    },
  );

  test(
    'Given a map with valid values to make a ResponseDto, '
    'When ResponseDto.fromMap is called with the map, '
    'Then an instance of ResponseDto should be returned',
    () {
      final responseDto = ResponseDto.fromMap(_responseMap);
      expect(responseDto, isA<ResponseDto>());
      expect(responseDto, isA<ResponseDto>());
      expect(responseDto.status, true);
      expect(responseDto.message, 'Success');
      expect(responseDto.data, {
        'id': '1',
      });
      expect(responseDto.code, 200);
    },
  );

  test(
    'Given a JSON with valid values to make a ResponseDto, '
    'When ResponseDto.fromJson is called with the map, '
    'Then an instance of ResponseDto should be returned',
    () {
      final responseJson = jsonEncode(_responseMap);
      final responseDto = ResponseDto.fromJson(responseJson);
      expect(responseDto, isA<ResponseDto>());
      expect(responseDto, isA<ResponseDto>());
      expect(responseDto.status, true);
      expect(responseDto.message, 'Success');
      expect(responseDto.data, {
        'id': '1',
      });
      expect(responseDto.code, 200);
    },
  );
  test(
    'Given a ResponseDto instance, '
    'When ResponseDto.copyWith is called on it with arguments, '
    'Then an instance of ResponseDto with different values should be returned',
    () {
      final responseDto = ResponseDto.fromMap(_responseMap);
      final newResponseDto = responseDto.copyWith(
        status: false,
        code: 201,
      );
      expect(newResponseDto, isA<ResponseDto>());
      expect(newResponseDto, isA<ResponseDto>());
      expect(newResponseDto.status, false);
      expect(newResponseDto.message, 'Success');
      expect(newResponseDto.data, {
        'id': '1',
      });
      expect(newResponseDto.code, 201);
    },
  );

  test(
    'Given a ResponseDto instance, '
    'When ResponseDto.toMap is called on it, '
    'Then a map that has all the right values should be returned',
    () {
      final responseDto = ResponseDto.fromMap(_responseMap);
      final responseMap = responseDto.toMap();
      expect(responseMap, isA<Map<String, dynamic>>());
      expect(responseMap, _responseMap);
    },
  );

  test(
    'Given a ResponseDto instance, '
    'When ResponseDto.toJson is called on it, '
    'Then a json string that has all the right values should be returned',
    () {
      final responseDto = ResponseDto.fromMap(_responseMap);
      final responseJson = responseDto.toJson();
      final expectedJsonValue = json.encode(_responseMap);
      expect(responseJson, expectedJsonValue);
    },
  );

  test(
    'Given two ResponseDto instances with the same property values, '
    'When they are compared with ==, '
    'Then evaluation of the expression should be true',
    () {
      final responseDto1 = ResponseDto.fromMap(_responseMap);
      final responseDto2 = ResponseDto.fromMap(_responseMap);
      expect(responseDto1 == responseDto2, true);
    },
  );

  test(
    'Given a ResponseDto instance , '
    'When ResponseDto.hashCode is called, '
    'Then an integer value should be returned',
    () {
      final responseDto = ResponseDto.fromMap(_responseMap);
      final hashCode = responseDto.hashCode;
      expect(hashCode, isA<int>());
    },
  );
  test(
    'Given a ResponseDto instance , '
    'When ResponseDto.toString is called, '
    'Then an a string matching the following format should be returned',
    () {
      final responseDto = ResponseDto.fromMap(_responseMap);
      final responseDTOString = responseDto.toString();
      expect(
        responseDTOString,
        'ResponseDTO(code: ${responseDto.code}, status: ${responseDto.status},'
        ' message: ${responseDto.message}, data: ${responseDto.data})',
      );
    },
  );
}
