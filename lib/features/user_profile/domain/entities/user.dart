import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class User {
  User({
    required this.id,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.dob,
    required this.gender,
    required this.idNumber,
    required this.idType,
    required this.issuingCountry,
    required this.phone,
    required this.status,
    required this.updatedAt,
    required this.userId,
  });

  final String id;
  final String city;
  final String country;
  final String createdAt;
  final String dob;
  final String gender;
  final String idNumber;
  final String idType;
  final String issuingCountry;
  final String phone;
  final String status;
  final String updatedAt;
  final UserId userId;

  User copyWith({
    String? id,
    String? city,
    String? country,
    String? createdAt,
    String? dob,
    String? gender,
    String? idNumber,
    String? idType,
    String? issuingCountry,
    String? phone,
    String? status,
    String? updatedAt,
    UserId? userId,
  }) {
    return User(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      idNumber: idNumber ?? this.idNumber,
      idType: idType ?? this.idType,
      issuingCountry: issuingCountry ?? this.issuingCountry,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
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
        other.idNumber == idNumber &&
        other.idType == idType &&
        other.issuingCountry == issuingCountry &&
        other.phone == phone &&
        other.status == status &&
        other.updatedAt == updatedAt &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        city.hashCode ^
        country.hashCode ^
        createdAt.hashCode ^
        dob.hashCode ^
        gender.hashCode ^
        idNumber.hashCode ^
        idType.hashCode ^
        issuingCountry.hashCode ^
        phone.hashCode ^
        status.hashCode ^
        updatedAt.hashCode ^
        userId.hashCode;
  }
}
