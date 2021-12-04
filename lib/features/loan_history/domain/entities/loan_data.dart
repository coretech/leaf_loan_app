import 'package:loan_app/core/domain/entities/entities.dart';

class LoanData {
  LoanData({
    required this.status,
    required this.id,
    required this.customerId,
    required this.loanTypeId,
    required this.loanPurpose,
    required this.currencyId,
    required this.dueDate,
    required this.requestedAmount,
    required this.interestAmount,
    required this.totalAmount,
    required this.remainingAmount,
    required this.duration,
    required this.requestDate,
    required this.createdAt,
    required this.updatedAt,
  });

  final String status;
  final String id;
  final String customerId;
  final LoanType loanTypeId;
  final String loanPurpose;
  final Currency currencyId;
  final String dueDate;
  final int requestedAmount;
  final int interestAmount;
  final int totalAmount;
  final int remainingAmount;
  final int duration;
  final String requestDate;
  final String createdAt;
  final String updatedAt;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoanData &&
        other.status == status &&
        other.id == id &&
        other.customerId == customerId &&
        other.loanTypeId == loanTypeId &&
        other.loanPurpose == loanPurpose &&
        other.currencyId == currencyId &&
        other.dueDate == dueDate &&
        other.requestedAmount == requestedAmount &&
        other.interestAmount == interestAmount &&
        other.totalAmount == totalAmount &&
        other.remainingAmount == remainingAmount &&
        other.duration == duration &&
        other.requestDate == requestDate &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        id.hashCode ^
        customerId.hashCode ^
        loanTypeId.hashCode ^
        loanPurpose.hashCode ^
        currencyId.hashCode ^
        dueDate.hashCode ^
        requestedAmount.hashCode ^
        interestAmount.hashCode ^
        totalAmount.hashCode ^
        remainingAmount.hashCode ^
        duration.hashCode ^
        requestDate.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'LoanData(status: $status, id: $id, customerId: $customerId, '
        'loanTypeId: $loanTypeId, loanPurpose: $loanPurpose, currencyId: '
        '$currencyId, dueDate: $dueDate, requestedAmount: $requestedAmount, '
        'interestAmount: $interestAmount, totalAmount: $totalAmount, '
        'remainingAmount: $remainingAmount, duration: $duration, '
        'requestDate: $requestDate, createdAt: $createdAt, '
        'updatedAt: $updatedAt)';
  }
}
