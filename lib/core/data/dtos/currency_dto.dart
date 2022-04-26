// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:loan_app/core/domain/entities/entities.dart';


class CurrencyDto {
  CurrencyDto({
    required this.id,
    required this.fiatCode,
    required this.name,
  });

  factory CurrencyDto.fromMap(Map<String, dynamic> map) {
    return CurrencyDto(
      id: map['id'] ,
      fiatCode: map['fiatCode'] ,
      name: map['name'] ,
    );
  }

  factory CurrencyDto.fromJson(String source) =>
      CurrencyDto.fromMap(json.decode(source));

  final String id;
  final String fiatCode;
  final String name;


  Currency toEntity() {
    return Currency(
      id: id,
      fiatCode: fiatCode,
      name: name,
    );
  }

  CurrencyDto copyWith({
    String? id,
    String? fiatCode,
    String? name,
    double? minLoanAmount,
    double? maxLoanAmount,
  }) {
    return CurrencyDto(
      id: id ?? this.id,
      fiatCode: fiatCode ?? this.fiatCode,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fiatCode': fiatCode,
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'CurrencyDto(id: $id, fiatCode: $fiatCode, '
        'name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyDto &&
        other.id == id &&
        other.fiatCode == fiatCode &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fiatCode.hashCode ^
        name.hashCode;
  }
}
