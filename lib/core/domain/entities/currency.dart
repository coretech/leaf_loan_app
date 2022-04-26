import 'dart:convert';

class Currency {
  Currency({
    required this.id,
    required this.fiatCode,
    required this.name,
  });

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map['id'] ,
      fiatCode: map['fiatCode'] ,
      name: map['name'] ,
    );
  }

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));

  final String id;
  final String fiatCode;
  final String name;

  Currency copyWith({
    String? id,
    String? fiatCode,
    String? name,
  }) {
    return Currency(
      id: id ?? this.id,
      fiatCode: fiatCode ?? this.fiatCode,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Currency &&
        other.id == id &&
        other.fiatCode == fiatCode &&
        other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ fiatCode.hashCode ^ name.hashCode;
  }

  @override
  String toString() {
    return 'Currency(id: $id, fiatCode: $fiatCode, name: $name)';
  }
}
