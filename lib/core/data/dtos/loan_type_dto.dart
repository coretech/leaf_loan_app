// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:loan_app/core/data/dtos/currency_dto.dart';
import 'package:loan_app/core/domain/domain.dart';

class LoanTypeDto {
  LoanTypeDto({
    required this.purpose,
    required this.id,
    required this.name,
    required this.description,
    required this.currencies,
    required this.minDuration,
    required this.maxDuration,
    required this.interestRate,
    required this.image,
  });

  factory LoanTypeDto.fromMap(Map<String, dynamic> map) {
    return LoanTypeDto(
      purpose: List<String>.from(map['purpose']),
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      currencies: List<CurrencyDto>.from(
        map['currencies']?.map((x) => CurrencyDto.fromMap(x)),
      ),
      minDuration: map['minduration']?.toInt() ?? 0,
      maxDuration: map['maxduration']?.toInt() ?? 0,
      interestRate: map['interestdate']?.toInt() ?? 0,
      image: map['image'] ?? '',
    );
  }

  factory LoanTypeDto.fromJson(String source) =>
      LoanTypeDto.fromMap(json.decode(source));

  final List<String> purpose;
  final String id;
  final String name;
  final String description;
  final List<CurrencyDto> currencies;
  final int minDuration;
  final int maxDuration;
  final int interestRate;
  final String image;

  LoanType toEntity() {
    return LoanType(
      purpose: purpose,
      id: id,
      name: name,
      description: description,
      currencies: List<Currency>.from(currencies.map((x) => x.toEntity())),
      minDuration: minDuration,
      maxDuration: maxDuration,
      interestRate: interestRate,
      image: image,
      createdAt: '',
      updatedAt: '',
    );
  }

  LoanTypeDto copyWith({
    List<String>? purpose,
    String? id,
    String? name,
    String? description,
    List<CurrencyDto>? currencies,
    int? minDuration,
    int? maxDuration,
    int? interestRate,
    String? image,
  }) {
    return LoanTypeDto(
      purpose: purpose ?? this.purpose,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      currencies: currencies ?? this.currencies,
      minDuration: minDuration ?? this.minDuration,
      maxDuration: maxDuration ?? this.maxDuration,
      interestRate: interestRate ?? this.interestRate,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'purpose': purpose,
      'id': id,
      'name': name,
      'description': description,
      'currencies': currencies.map((x) => x.toMap()).toList(),
      'minDuration': minDuration,
      'maxDuration': maxDuration,
      'interestRate': interestRate,
      'image': image,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'LoanTypeDto(purpose: $purpose, id: $id, name: $name, description: '
        '$description, currencies: $currencies, minDuration: $minDuration, '
        'maxDuration: $maxDuration, interestRate: $interestRate, '
        'image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoanTypeDto &&
        listEquals(other.purpose, purpose) &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        listEquals(other.currencies, currencies) &&
        other.minDuration == minDuration &&
        other.maxDuration == maxDuration &&
        other.interestRate == interestRate &&
        other.image == image;
  }

  @override
  int get hashCode {
    return purpose.hashCode ^
        id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        currencies.hashCode ^
        minDuration.hashCode ^
        maxDuration.hashCode ^
        interestRate.hashCode ^
        image.hashCode;
  }
}
