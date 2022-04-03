import 'package:loan_app/core/domain/entities/entities.dart';

class LoanData {
  LoanData({
    required this.status,
    required this.id,
    required this.loanType,
    required this.loanPurpose,
    required this.currency,
    required this.dueDate,
    required this.requestedAmount,
    required this.interestAmount,
    required this.totalAmount,
    required this.remainingAmount,
    required this.duration,
    required this.requestDate,
  });

  final String status;
  final String id;
  final String loanType;
  final String loanPurpose;
  final Currency currency;
  final String dueDate;
  final double requestedAmount;
  final double interestAmount;
  final double totalAmount;
  final double remainingAmount;
  final int duration;
  final String requestDate;

  LoanData copyWith({
    String? status,
    String? id,
    String? loanType,
    String? loanPurpose,
    Currency? currency,
    String? dueDate,
    double? requestedAmount,
    double? interestAmount,
    double? totalAmount,
    double? remainingAmount,
    int? duration,
    String? requestDate,
  }) {
    return LoanData(
      status: status ?? this.status,
      id: id ?? this.id,
      loanType: loanType ?? this.loanType,
      loanPurpose: loanPurpose ?? this.loanPurpose,
      currency: currency ?? this.currency,
      dueDate: dueDate ?? this.dueDate,
      requestedAmount: requestedAmount ?? this.requestedAmount,
      interestAmount: interestAmount ?? this.interestAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      remainingAmount: remainingAmount ?? this.remainingAmount,
      duration: duration ?? this.duration,
      requestDate: requestDate ?? this.requestDate,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoanData &&
        other.status == status &&
        other.id == id &&
        other.loanType == loanType &&
        other.loanPurpose == loanPurpose &&
        other.currency == currency &&
        other.dueDate == dueDate &&
        other.requestedAmount == requestedAmount &&
        other.interestAmount == interestAmount &&
        other.totalAmount == totalAmount &&
        other.remainingAmount == remainingAmount &&
        other.duration == duration &&
        other.requestDate == requestDate;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        id.hashCode ^
        loanType.hashCode ^
        loanPurpose.hashCode ^
        currency.hashCode ^
        dueDate.hashCode ^
        requestedAmount.hashCode ^
        interestAmount.hashCode ^
        totalAmount.hashCode ^
        remainingAmount.hashCode ^
        duration.hashCode ^
        requestDate.hashCode;
  }

  @override
  String toString() {
    return 'LoanData(status: $status, id: $id, loanType: $loanType, '
        'loanPurpose: $loanPurpose, currency: $currency, dueDate: '
        '$dueDate, requestedAmount: $requestedAmount, interestAmount: '
        '$interestAmount, totalAmount: $totalAmount, remainingAmount: '
        '$remainingAmount, duration: $duration, requestDate: $requestDate)';
  }
}
