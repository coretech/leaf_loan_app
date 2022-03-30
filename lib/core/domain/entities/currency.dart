import 'dart:convert';

class Currency {
  Currency({
    required this.id,
    required this.fiatCode,
    required this.name,
    required this.minLoanAmount,
    required this.maxLoanAmount,
  });
  final String id;
  final String fiatCode;
  final String name;
  final double minLoanAmount;
  final double maxLoanAmount;

  Currency copyWith({
    String? id,
    String? fiatCode,
    String? name,
    double? minLoanAmount,
    double? maxLoanAmount,
  }) {
    return Currency(
      id: id ?? this.id,
      fiatCode: fiatCode ?? this.fiatCode,
      name: name ?? this.name,
      minLoanAmount: minLoanAmount ?? this.minLoanAmount,
      maxLoanAmount: maxLoanAmount ?? this.maxLoanAmount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Currency &&
        other.id == id &&
        other.fiatCode == fiatCode &&
        other.name == name &&
        other.minLoanAmount == minLoanAmount &&
        other.maxLoanAmount == maxLoanAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fiatCode.hashCode ^
        name.hashCode ^
        minLoanAmount.hashCode ^
        maxLoanAmount.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fiatCode': fiatCode,
      'name': name,
      'minLoanAmount': minLoanAmount,
      'maxLoanAmount': maxLoanAmount,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map['id'] ?? '',
      fiatCode: map['fiatCode'] ?? '',
      name: map['name'] ?? '',
      minLoanAmount: map['minLoanAmount']?.toDouble() ?? 0.0,
      maxLoanAmount: map['maxLoanAmount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Currency(id: $id, fiatCode: $fiatCode, name: $name, minLoanAmount: $minLoanAmount, maxLoanAmount: $maxLoanAmount)';
  }
}
