import 'dart:convert';

import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class UserDto {
  UserDto({
    required this.id,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.dob,
    required this.email,
    required this.gender,
    required this.phone,
    required this.status,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.username,
  });

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'],
      city: map['city'],
      country: map['country'],
      createdAt: map['createdAt'],
      dob: map['dob'],
      email: map['email'],
      gender: map['gender'],
      phone: map['phone'],
      status: map['status'],
      updatedAt: map['updatedAt'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      username: map['username'],
    );
  }

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source));

  final String id;
  final String city;
  final String country;
  final String createdAt;
  final String dob;
  final String? email;
  final String gender;
  final String phone;
  final String status;
  final String updatedAt;
  final String firstName;
  final String lastName;
  final String username;

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
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
    );
  }

  UserDto copyWith({
    String? id,
    String? city,
    String? country,
    String? createdAt,
    String? dob,
    String? email,
    String? gender,
    String? idNumber,
    String? idType,
    String? issuingCountry,
    String? phone,
    String? status,
    String? street,
    String? updatedAt,
    String? firstName,
    String? lastName,
    String? username,
  }) {
    return UserDto(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      dob: dob ?? this.dob,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'city': city,
      'country': country,
      'createdAt': createdAt,
      'dob': dob,
      'email': email,
      'gender': gender,
      'phone': phone,
      'status': status,
      'updatedAt': updatedAt,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserDto(id: $id, city: $city, country: $country, '
        'createdAt: $createdAt, dob: $dob, email: $email, gender: '
        '$gender, phone: $phone, status: $status, updatedAt: '
        '$updatedAt, firstName: $firstName, lastName: $lastName, '
        'username: $username)';
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
        other.email == email &&
        other.gender == gender &&
        other.phone == phone &&
        other.status == status &&
        other.updatedAt == updatedAt &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.username == username;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        city.hashCode ^
        country.hashCode ^
        createdAt.hashCode ^
        dob.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        status.hashCode ^
        updatedAt.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        username.hashCode;
  }
}
