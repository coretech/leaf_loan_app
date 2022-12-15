// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/data/mappers/mappers.dart';
import 'package:loan_app/core/domain/domain.dart';

abstract class LoanTypeMapper {
  static LoanType fromMap(Map<String, dynamic> map) {
    return LoanType(
      purpose: List<String>.from(map['purpose']),
      id: map['id'],
      name: map['name'],
      description: map['description'],
      currencies: List<LoanCurrency>.from(
        map['currencies']?.map((x) => LoanCurrencyDto.fromMap(x).toEntity()),
      ),
      minDuration: map['minDuration']?.toInt(),
      maxDuration: map['maxDuration']?.toInt(),
      interestRate: map['interestRate']?.toDouble(),
      image: map['image'],
      loanLevel: LoanLevelMapper.fromMap(map['level']),
    );
  }

  static LoanType fromJson(String source) => fromMap(json.decode(source));
}
