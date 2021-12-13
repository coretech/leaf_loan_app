import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/domain/entities/entities.dart';

class LoanTypeDTO {
  LoanTypeDTO({
    required this.purpose,
    required this.id,
    required this.name,
    required this.description,
    required this.currencies,
    required this.minduration,
    required this.maxduration,
    required this.interestrate,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LoanTypeDTO.fromMap(Map<String, dynamic> map) {
    return LoanTypeDTO(
      purpose:
          map['purpose'] != null ? List<String>.from(map['purpose']) : null,
      id: map['_id'],
      name: map['name'],
      description: map['description'],
      currencies: List<CurrencyDTO>.from(
        // ignore: avoid_dynamic_calls
        map['currencies']?.map((x) => CurrencyDTO.fromMap(x)),
      ),
      minduration: map['minduration'],
      maxduration: map['maxduration'],
      interestrate: map['interestrate'],
      image: map['image'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  factory LoanTypeDTO.fromJson(String source) =>
      LoanTypeDTO.fromMap(json.decode(source));

  final List<String>? purpose;
  final String id;
  final String name;
  final String description;
  final List<CurrencyDTO> currencies;
  final int minduration;
  final int maxduration;
  final int interestrate;
  final String image;
  final String createdAt;
  final String updatedAt;

  LoanType toEntity() {
    return LoanType(
      purpose: purpose,
      id: id,
      name: name,
      description: description,
      currencies: List<Currency>.from(currencies.map((x) => x.toEntity())),
      minDuration: minduration,
      maxDuration: maxduration,
      interestRate: interestrate,
      image: image,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  LoanTypeDTO copyWith({
    List<String>? purpose,
    String? id,
    String? name,
    String? description,
    List<CurrencyDTO>? currencies,
    int? minduration,
    int? maxduration,
    int? interestrate,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    return LoanTypeDTO(
      purpose: purpose ?? this.purpose,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      currencies: currencies ?? this.currencies,
      minduration: minduration ?? this.minduration,
      maxduration: maxduration ?? this.maxduration,
      interestrate: interestrate ?? this.interestrate,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'purpose': purpose,
      '_id': id,
      'name': name,
      'description': description,
      'currencies': currencies.map((x) => x.toMap()).toList(),
      'minduration': minduration,
      'maxduration': maxduration,
      'interestrate': interestrate,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'LoanTypeDTO(purpose: $purpose, _id: $id, name: $name, description:'
        ' $description, currencies: $currencies, minduration: $minduration, '
        'maxduration: $maxduration, interestrate: $interestrate, image: '
        '$image, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoanTypeDTO &&
        listEquals(other.purpose, purpose) &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        listEquals(other.currencies, currencies) &&
        other.minduration == minduration &&
        other.maxduration == maxduration &&
        other.interestrate == interestrate &&
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
        minduration.hashCode ^
        maxduration.hashCode ^
        interestrate.hashCode ^
        image.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
