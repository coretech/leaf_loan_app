import 'dart:convert';

import 'package:loan_app/features/user_profile/data/dtos/dtos.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class UserDTO {
  UserDTO({
    required this.id,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.dob,
    required this.gender,
    required this.idnumber,
    required this.idtype,
    required this.issuingcountry,
    required this.phone,
    required this.status,
    required this.updatedAt,
    required this.userid,
  });

  factory UserDTO.fromMap(Map<String, dynamic> map) {
    return UserDTO(
      id: map['_id'],
      city: map['city'],
      country: map['country'],
      createdAt: map['createdAt'],
      dob: map['dob'],
      gender: map['gender'],
      idnumber: map['idnumber'],
      idtype: map['idtype'],
      issuingcountry: map['issuingcountry'],
      phone: map['phone'],
      status: map['status'],
      updatedAt: map['updatedAt'],
      userid: UserIdDTO.fromMap(map['userid']),
    );
  }

  factory UserDTO.fromJson(String source) =>
      UserDTO.fromMap(json.decode(source));

  final String id;
  final String city;
  final String country;
  final String createdAt;
  final String dob;
  final String gender;
  final String idnumber;
  final String idtype;
  final String issuingcountry;
  final String phone;
  final String status;
  final String updatedAt;
  final UserIdDTO userid;

  User toEntity() {
    return User(
      id: id,
      city: city,
      country: country,
      createdAt: createdAt,
      dob: dob,
      gender: gender,
      idNumber: idnumber,
      idType: idtype,
      issuingCountry: issuingcountry,
      phone: phone,
      status: status,
      updatedAt: updatedAt,
      userId: userid.toEntity(),
    );
  }

  UserDTO copyWith({
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
  }) {
    return UserDTO(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      idnumber: idnumber ?? this.idnumber,
      idtype: idtype ?? this.idtype,
      issuingcountry: issuingcountry ?? this.issuingcountry,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      userid: userid ?? this.userid,
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
      'idnumber': idnumber,
      'idtype': idtype,
      'issuingcountry': issuingcountry,
      'phone': phone,
      'status': status,
      'updatedAt': updatedAt,
      'userid': userid.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Data(_id: $id, city: $city, country: $country,'
        ' createdAt: $createdAt, dob: $dob, gender: $gender,'
        ' idnumber: $idnumber, idtype: $idtype, issuingcountry:'
        ' $issuingcountry, phone: $phone, status: $status, updatedAt:'
        ' $updatedAt, userid: $userid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDTO &&
        other.id == id &&
        other.city == city &&
        other.country == country &&
        other.createdAt == createdAt &&
        other.dob == dob &&
        other.gender == gender &&
        other.idnumber == idnumber &&
        other.idtype == idtype &&
        other.issuingcountry == issuingcountry &&
        other.phone == phone &&
        other.status == status &&
        other.updatedAt == updatedAt &&
        other.userid == userid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        city.hashCode ^
        country.hashCode ^
        createdAt.hashCode ^
        dob.hashCode ^
        gender.hashCode ^
        idnumber.hashCode ^
        idtype.hashCode ^
        issuingcountry.hashCode ^
        phone.hashCode ^
        status.hashCode ^
        updatedAt.hashCode ^
        userid.hashCode;
  }
}