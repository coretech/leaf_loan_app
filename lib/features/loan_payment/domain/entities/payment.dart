import 'package:loan_app/core/domain/entities/entities.dart';

class Payment {
  Payment({
    required this.status,
    required this.id,
    required this.customerId,
    required this.principalAmount,
    required this.interestAmount,
    required this.paymentAmount,
    required this.createdAt,
    required this.updatedAt,
  });

  final String status;
  final String id;
  final String customerId;
  final double principalAmount;
  final double interestAmount;
  final double paymentAmount;
  final String createdAt;
  final String updatedAt;

  Payment copyWith({
    String? status,
    String? id,
    String? customerId,
    LoanType? loanId,
    double? principalAmount,
    double? interestAmount,
    double? paymentAmount,
    String? createdAt,
    String? updatedAt,
  }) {
    return Payment(
      status: status ?? this.status,
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      principalAmount: principalAmount ?? this.principalAmount,
      interestAmount: interestAmount ?? this.interestAmount,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Payment(status: $status, id: $id, customerId: $customerId, '
        'principalAmount: $principalAmount, interestAmount: '
        '$interestAmount, paymentAmount: $paymentAmount, '
        'createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Payment &&
        other.status == status &&
        other.id == id &&
        other.customerId == customerId &&
        other.principalAmount == principalAmount &&
        other.interestAmount == interestAmount &&
        other.paymentAmount == paymentAmount &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        id.hashCode ^
        customerId.hashCode ^
        principalAmount.hashCode ^
        interestAmount.hashCode ^
        paymentAmount.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
