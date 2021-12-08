import 'package:loan_app/core/domain/entities/entities.dart';

class Payment {
  Payment({
    required this.status,
    required this.id,
    required this.customerId,
    required this.loanId,
    required this.principalAmount,
    required this.interestAmount,
    required this.paymentAmount,
    required this.currencyId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String status;
  final String id;
  final String customerId;
  final LoanType loanId;
  final int principalAmount;
  final int interestAmount;
  final int paymentAmount;
  final String currencyId;
  final String createdAt;
  final String updatedAt;

  Payment copyWith({
    String? status,
    String? id,
    String? customerId,
    LoanType? loanId,
    int? principalAmount,
    int? interestAmount,
    int? paymentAmount,
    String? currencyId,
    String? createdAt,
    String? updatedAt,
  }) {
    return Payment(
      status: status ?? this.status,
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      loanId: loanId ?? this.loanId,
      principalAmount: principalAmount ?? this.principalAmount,
      interestAmount: interestAmount ?? this.interestAmount,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      currencyId: currencyId ?? this.currencyId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Payment(status: $status, _id: $id, customerId: $customerId, '
        'loanId: $loanId, principalAmount: $principalAmount, interestAmount: '
        '$interestAmount, paymentAmount: $paymentAmount, currencyId: '
        '$currencyId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Payment &&
        other.status == status &&
        other.id == id &&
        other.customerId == customerId &&
        other.loanId == loanId &&
        other.principalAmount == principalAmount &&
        other.interestAmount == interestAmount &&
        other.paymentAmount == paymentAmount &&
        other.currencyId == currencyId &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        id.hashCode ^
        customerId.hashCode ^
        loanId.hashCode ^
        principalAmount.hashCode ^
        interestAmount.hashCode ^
        paymentAmount.hashCode ^
        currencyId.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
