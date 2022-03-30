import 'dart:convert';

import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class StatDto {
  final String id;
  final String title;
  final String description;
  final String unit;
  final num value;
  StatDto({
    required this.id,
    required this.title,
    required this.description,
    required this.unit,
    required this.value,
  });

  StatDto copyWith({
    String? id,
    String? title,
    String? description,
    String? unit,
    num? value,
  }) {
    return StatDto(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      unit: unit ?? this.unit,
      value: value ?? this.value,
    );
  }

  Stat toEntity() {
    return CountStat(
      title: title,
      description: description,
      unit: unit,
      value: value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'unit': unit,
      'value': value,
    };
  }

  factory StatDto.fromMap(Map<String, dynamic> map) {
    return StatDto(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      unit: map['unit'] ?? '',
      value: map['value']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatDto.fromJson(String source) =>
      StatDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StatDto(id: $id, title: $title, description: $description,'
        ' unit: $unit, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatDto &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.unit == unit &&
        other.value == value;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        unit.hashCode ^
        value.hashCode;
  }
}
