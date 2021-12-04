import 'package:flutter/foundation.dart';

import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class UserId {
  UserId({
    required this.id,
    required this.roleId,
    required this.status,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final List<RoleId> roleId;
  final String status;
  final String firstName;
  final String lastName;
  final String username;
  final String createdAt;
  final String updatedAt;

  UserId copyWith({
    String? id,
    List<RoleId>? roleId,
    String? status,
    String? firstName,
    String? lastName,
    String? username,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserId(
      id: id ?? this.id,
      roleId: roleId ?? this.roleId,
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserId &&
        other.id == id &&
        listEquals(other.roleId, roleId) &&
        other.status == status &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.username == username &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        roleId.hashCode ^
        status.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        username.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
