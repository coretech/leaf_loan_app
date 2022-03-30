import 'dart:convert';

import 'package:loan_app/core/domain/entities/entities.dart';

class CurrencyDto {
  final String id;
  final String fiatCode;
  final String name;
  final int minLoanAmount;
  final int maxLoanAmount;
  CurrencyDto({
    required this.id,
    required this.fiatCode,
    required this.name,
    required this.minLoanAmount,
    required this.maxLoanAmount,
  });

  Currency toEntity() {
    return Currency(
      currencyId: CurrencyId(
        id: id,
        updatedAt: '',
        description: '',
        createdAt: '',
        name: name,
        fiatCode: fiatCode,
        country: '',
      ),
      minLoanAmount: minLoanAmount,
      maxLoanAmount: maxLoanAmount,
    );
  }

  CurrencyDto copyWith({
    String? id,
    String? fiatCode,
    String? name,
    int? minLoanAmount,
    int? maxLoanAmount,
  }) {
    return CurrencyDto(
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

  factory CurrencyDto.fromMap(Map<String, dynamic> map) {
    return CurrencyDto(
      id: map['id'] ?? '',
      fiatCode: map['fiatcode'] ?? '',
      name: map['name'] ?? '',
      minLoanAmount: map['minloanamount']?.toInt() ?? 0,
      maxLoanAmount: map['maxloanamount']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrencyDto.fromJson(String source) =>
      CurrencyDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CurrencyDto(id: $id, fiatCode: $fiatCode, name: $name, minLoanAmount: $minLoanAmount, maxLoanAmount: $maxLoanAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyDto &&
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
