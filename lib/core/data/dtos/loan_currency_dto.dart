// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:loan_app/core/domain/entities/entities.dart';


class LoanCurrencyDto {
  LoanCurrencyDto({
    required this.id,
    required this.fiatCode,
    required this.name,
    required this.minLoanAmount,
    required this.maxLoanAmount,
  });

  factory LoanCurrencyDto.fromMap(Map<String, dynamic> map) {
    return LoanCurrencyDto(
      id: map['id'] ,
      fiatCode: map['fiatCode'] ,
      name: map['name'] ,
      minLoanAmount: map['minLoanAmount']?.toDouble() ,
      maxLoanAmount: map['maxLoanAmount']?.toDouble() ,
    );
  }

  factory LoanCurrencyDto.fromJson(String source) =>
      LoanCurrencyDto.fromMap(json.decode(source));

  final String id;
  final String fiatCode;
  final String name;
  final double minLoanAmount;
  final double maxLoanAmount;

  LoanCurrency toEntity() {
    return LoanCurrency(
      id: id,
      fiatCode: fiatCode,
      name: name,
      minLoanAmount: minLoanAmount,
      maxLoanAmount: maxLoanAmount,
    );
  }

  LoanCurrencyDto copyWith({
    String? id,
    String? fiatCode,
    String? name,
    double? minLoanAmount,
    double? maxLoanAmount,
  }) {
    return LoanCurrencyDto(
      id: id ?? this.id,
      fiatCode: fiatCode ?? this.fiatCode,
      name: name ?? this.name,
      minLoanAmount: minLoanAmount ?? this.minLoanAmount,
      maxLoanAmount: maxLoanAmount ?? this.maxLoanAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fiatCode': fiatCode,
      'name': name,
      'minLoanAmount': minLoanAmount,
      'maxLoanAmount': maxLoanAmount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'LoanCurrencyDto(id: $id, fiatCode: $fiatCode, '
        'name: $name, minLoanAmount: $minLoanAmount, '
        'maxLoanAmount: $maxLoanAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoanCurrencyDto &&
        other.id == id &&
        other.fiatCode == fiatCode &&
        other.name == name &&
        other.minLoanAmount == minLoanAmount &&
        other.maxLoanAmount == maxLoanAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fiatCode.hashCode ^
        name.hashCode ^
        minLoanAmount.hashCode ^
        maxLoanAmount.hashCode;
  }
}
