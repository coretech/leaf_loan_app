import 'dart:convert';

import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class RoleIdDTO {
  RoleIdDTO({
    required this.id,
    required this.name,
  });

  factory RoleIdDTO.fromMap(Map<String, dynamic> map) {
    return RoleIdDTO(
      id: map['_id'],
      name: map['name'],
    );
  }

  factory RoleIdDTO.fromJson(String source) =>
      RoleIdDTO.fromMap(json.decode(source));

  final String id;
  final String name;

  RoleId toEntity() {
    return RoleId(
      id: id,
      name: name,
    );
  }

  RoleIdDTO copyWith({
    String? id,
    String? name,
  }) {
    return RoleIdDTO(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'RoleIdDTO(_id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoleIdDTO && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
