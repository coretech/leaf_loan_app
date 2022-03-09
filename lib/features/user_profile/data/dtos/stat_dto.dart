import 'dart:convert';

import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class StatDTO {
  StatDTO({
    required this.title,
    required this.description,
    required this.unit,
    required this.value,
  });

  factory StatDTO.fromJson(String source) =>
      StatDTO.fromMap(json.decode(source));

  factory StatDTO.fromMap(Map<String, dynamic> map) {
    return StatDTO(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      unit: map['unit'] ?? '',
      value: map['value'],
    );
  }

  final String title;
  final String description;
  final String unit;
  final dynamic value;

  Stat toEntity() {
    if (value is num) {
      return CountStat(
        title: title,
        description: description,
        unit: unit,
        value: value,
      );
    } else {
      return MoneyStat(
        title: title,
        description: description,
        unit: unit,
        value: value,
      );
    }
  }

  StatDTO copyWith({
    String? title,
    String? description,
    String? unit,
    dynamic value,
  }) {
    return StatDTO(
      title: title ?? this.title,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'unit': unit,
      'value': value,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'StatDTO(title: $title, description: $description, '
        'unit: $unit, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatDTO &&
        other.title == title &&
        other.description == description &&
        other.unit == unit &&
        other.value == value;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        unit.hashCode ^
        value.hashCode;
  }
}
