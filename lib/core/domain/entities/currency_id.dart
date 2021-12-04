class CurrencyId {
  CurrencyId({
    required this.id,
    required this.name,
    required this.fiatCode,
    required this.description,
    required this.country,
    required this.createdAt,
    required this.updatedAt,
  });
  final String id;
  final String name;
  final String fiatCode;
  final String description;
  final String country;
  final String createdAt;
  final String updatedAt;

  CurrencyId copyWith({
    String? id,
    String? name,
    String? fiatCode,
    String? description,
    String? country,
    String? createdAt,
    String? updatedAt,
  }) {
    return CurrencyId(
      id: id ?? this.id,
      name: name ?? this.name,
      fiatCode: fiatCode ?? this.fiatCode,
      description: description ?? this.description,
      country: country ?? this.country,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyId &&
        other.id == id &&
        other.name == name &&
        other.fiatCode == fiatCode &&
        other.description == description &&
        other.country == country &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        fiatCode.hashCode ^
        description.hashCode ^
        country.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
