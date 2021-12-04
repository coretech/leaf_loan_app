import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:loan_app/features/user_profile/data/dtos/dtos.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class UserIdDTO {
  UserIdDTO({
    required this.roleid,
    required this.status,
    required this.id,
    required this.fname,
    required this.lname,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserIdDTO.fromMap(Map<String, dynamic> map) {
    return UserIdDTO(
      roleid:
          // ignore: avoid_dynamic_calls
          List<RoleIdDTO>.from(map['roleid']?.map((x) => RoleIdDTO.fromMap(x))),
      status: map['status'],
      id: map['_id'],
      fname: map['fname'],
      lname: map['lname'],
      username: map['username'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  factory UserIdDTO.fromJson(String source) =>
      UserIdDTO.fromMap(json.decode(source));

  final List<RoleIdDTO> roleid;
  final String status;
  final String id;
  final String fname;
  final String lname;
  final String username;
  final String createdAt;
  final String updatedAt;

  UserId toEntity() {
    return UserId(
      roleId: roleid.map((x) => x.toEntity()).toList(),
      status: status,
      id: id,
      firstName: fname,
      lastName: lname,
      username: username,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  UserIdDTO copyWith({
    List<RoleIdDTO>? roleid,
    String? status,
    String? id,
    String? fname,
    String? lname,
    String? username,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserIdDTO(
      roleid: roleid ?? this.roleid,
      status: status ?? this.status,
      id: id ?? this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'roleid': roleid.map((x) => x.toMap()).toList(),
      'status': status,
      '_id': id,
      'fname': fname,
      'lname': lname,
      'username': username,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Userid(roleid: $roleid, status: $status, _id: $id, fname: $fname, '
        'lname: $lname, username: $username, createdAt: $createdAt, updatedAt:'
        ' $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserIdDTO &&
        listEquals(other.roleid, roleid) &&
        other.status == status &&
        other.id == id &&
        other.fname == fname &&
        other.lname == lname &&
        other.username == username &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return roleid.hashCode ^
        status.hashCode ^
        id.hashCode ^
        fname.hashCode ^
        lname.hashCode ^
        username.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
