import 'package:flutter/foundation.dart';

import 'package:loan_app/core/domain/entities/entities.dart';

class LoanType {
  LoanType({
    required this.purpose,
    required this.id,
    required this.name,
    required this.description,
    required this.currencies,
    required this.loanLevel,
    required this.minDuration,
    required this.maxDuration,
    required this.interestRate,
    required this.image,
  });
  final List<String> purpose;
  final String id;
  final String name;
  final String description;
  final List<LoanCurrency> currencies;
  final LoanLevel loanLevel;
  final int minDuration;
  final int maxDuration;
  final double interestRate;
  final String image;

  bool get hasCurrencies => currencies.isNotEmpty;

  LoanType copyWith({
    List<String>? purpose,
    String? id,
    String? name,
    String? description,
    List<LoanCurrency>? currencies,
    LoanLevel? loanLevel,
    int? minDuration,
    int? maxDuration,
    double? interestRate,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    return LoanType(
      purpose: purpose ?? this.purpose,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      currencies: currencies ?? this.currencies,
      loanLevel: loanLevel ?? this.loanLevel,
      minDuration: minDuration ?? this.minDuration,
      maxDuration: maxDuration ?? this.maxDuration,
      interestRate: interestRate ?? this.interestRate,
      image: image ?? this.image,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoanType &&
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
