import 'dart:convert';

import 'package:flutter/foundation.dart';

class User {
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
  final Userid userid;
  User({
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

  User copyWith({
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
    Userid? userid,
  }) {
    return User(
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

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
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
      userid: Userid.fromMap(map['userid']),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(_id: $id, city: $city, country: $country, createdAt: $createdAt, dob: $dob, gender: $gender, idnumber: $idnumber, idtype: $idtype, issuingcountry: $issuingcountry, phone: $phone, status: $status, updatedAt: $updatedAt, userid: $userid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
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

class Userid {
  final List<Roleid> roleid;
  final String status;
  final String id;
  final String fname;
  final String lname;
  final String username;
  final String createdAt;
  final String updatedAt;
  final int v;
  Userid({
    required this.roleid,
    required this.status,
    required this.id,
    required this.fname,
    required this.lname,
    required this.username,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  Userid copyWith({
    List<Roleid>? roleid,
    String? status,
    String? id,
    String? fname,
    String? lname,
    String? username,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    return Userid(
      roleid: roleid ?? this.roleid,
      status: status ?? this.status,
      id: id ?? this.id,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
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
      '__v': v,
    };
  }

  factory Userid.fromMap(Map<String, dynamic> map) {
    return Userid(
      roleid: List<Roleid>.from(map['roleid']?.map((x) => Roleid.fromMap(x))),
      status: map['status'],
      id: map['_id'],
      fname: map['fname'],
      lname: map['lname'],
      username: map['username'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      v: map['__v']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Userid.fromJson(String source) => Userid.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Userid(roleid: $roleid, status: $status, _id: $id, fname: $fname, lname: $lname, username: $username, createdAt: $createdAt, updatedAt: $updatedAt, __v: $v)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Userid &&
        listEquals(other.roleid, roleid) &&
        other.status == status &&
        other.id == id &&
        other.fname == fname &&
        other.lname == lname &&
        other.username == username &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v;
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
        updatedAt.hashCode ^
        v.hashCode;
  }
}

class Roleid {
  final String id;
  final String name;
  Roleid({
    required this.id,
    required this.name,
  });

  Roleid copyWith({
    String? id,
    String? name,
  }) {
    return Roleid(
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

  factory Roleid.fromMap(Map<String, dynamic> map) {
    return Roleid(
      id: map['_id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Roleid.fromJson(String source) => Roleid.fromMap(json.decode(source));

  @override
  String toString() => 'Roleid(_id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Roleid && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
