import 'package:flutter/foundation.dart';
import 'package:loan_app/core/domain/entities/entities.dart';

class LoanType {
  LoanType({
    required this.purpose,
    required this.id,
    required this.name,
    required this.description,
    required this.currencies,
    required this.minDuration,
    required this.maxDuration,
    required this.interestRate,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });
  final List<String> purpose;
  final String id;
  final String name;
  final String description;
  final List<LoanCurrency> currencies;
  final int minDuration;
  final int maxDuration;
  final double interestRate;
  final String image;
  final String createdAt;
  final String updatedAt;

  bool get hasCurrencies => currencies.isNotEmpty;

  LoanType copyWith({
    List<String>? purpose,
    String? id,
    String? name,
    String? description,
    List<LoanCurrency>? currencies,
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
      minDuration: minDuration ?? this.minDuration,
      maxDuration: maxDuration ?? this.maxDuration,
      interestRate: interestRate ?? this.interestRate,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
        other.image == image &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
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
        image.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
