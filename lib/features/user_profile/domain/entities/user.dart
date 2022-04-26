class User {
  User({
    required this.id,
    required this.city,
    required this.country,
    required this.createdAt,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.status,
    required this.updatedAt,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.email,
  });

  final String id;
  final String city;
  final String country;
  final String createdAt;
  final String dob;
  final String gender;
  final String phone;
  final String status;
  final String updatedAt;
  final String firstName;
  final String lastName;
  final String username;
  final String? email;

  User copyWith({
    String? id,
    String? city,
    String? country,
    String? createdAt,
    String? dob,
    String? gender,
    String? phone,
    String? status,
    String? updatedAt,
    String? street,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
  }) {
    return User(
      id: id ?? this.id,
      city: city ?? this.city,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
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
        other.phone == phone &&
        other.status == status &&
        other.updatedAt == updatedAt &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.username == username &&
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
        firstName.hashCode ^
        lastName.hashCode ^
        username.hashCode ^
        email.hashCode;
  }
}
