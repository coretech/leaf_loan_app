import 'dart:convert';

class LoanCurrency {
  LoanCurrency({
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

  LoanCurrency copyWith({
    String? id,
    String? fiatCode,
    String? name,
    double? minLoanAmount,
    double? maxLoanAmount,
  }) {
    return LoanCurrency(
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

    return other is LoanCurrency &&
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

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'LoanCurrency(id: $id, fiatCode: $fiatCode, name: $name, '
        'minLoanAmount: $minLoanAmount, maxLoanAmount: $maxLoanAmount)';
  }
}
