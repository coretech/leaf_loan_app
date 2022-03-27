import 'dart:convert';

import 'package:loan_app/features/user_profile/data/dtos/dtos.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class UserDto {
  UserDto({
    required this.id,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.status,
    required this.updatedAt,
    required this.userid,
    this.email,
  });

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['_id'],
      city: map['city'],
      country: map['country'],
      createdAt: map['createdAt'],
      dob: map['dob'],
      gender: map['gender'],
      phone: map['phone'],
      status: map['status'],
      updatedAt: map['updatedAt'],
      userid: UserIdDTO.fromMap(map['userid']),
      email: map['email'],
    );
  }

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source));

  final String id;
  final String city;
  final String country;
  final String createdAt;
  final String dob;
  final String gender;
  final String phone;
  final String status;
  final String updatedAt;
  final UserIdDTO userid;
  final String? email;

  User toEntity() {
    return User(
      id: id,
      city: city,
      country: country,
      createdAt: createdAt,
      dob: dob,
      gender: gender,
      phone: phone,
      status: status,
      updatedAt: updatedAt,
      userId: userid.toEntity(),
      email: email,
    );
  }

  UserDto copyWith({
    String? id,
    String? city,
    String? country,
    String? createdAt,
    String? dob,
    String? gender,
    String? idnumber,
    String? idtype,
    String? issuingcountry,
    String? phone,
    String? status,
    String? updatedAt,
    UserIdDTO? userid,
    String? email,
  }) {
    return UserDto(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      userid: userid ?? this.userid,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'city': city,
      'country': country,
      'createdAt': createdAt,
      'dob': dob,
      'gender': gender,
      'phone': phone,
      'status': status,
      'updatedAt': updatedAt,
      'userid': userid.toMap(),
      'email': email,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Data(_id: $id, city: $city, country: $country,'
        ' createdAt: $createdAt, dob: $dob, gender: $gender,'
        ' phone: $phone, status: $status, updatedAt:'
        ' $updatedAt, userid: $userid, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDto &&
        other.id == id &&
        other.city == city &&
        other.country == country &&
        other.createdAt == createdAt &&
        other.dob == dob &&
        other.gender == gender &&
        other.phone == phone &&
        other.status == status &&
        other.updatedAt == updatedAt &&
        other.userid == userid &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        city.hashCode ^
        country.hashCode ^
        createdAt.hashCode ^
        dob.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        status.hashCode ^
        updatedAt.hashCode ^
        userid.hashCode ^
        email.hashCode;
  }
}
