import 'dart:convert';

import 'package:loan_app/core/data/data.dart';
import 'package:loan_app/core/domain/entities/entities.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';

class LoanDataDto {
  final String status;
  final String id;
  final String loanType;
  final String loanPurpose;
  final CurrencyDto currency;
  final String dueDate;
  final double requestedAmount;
  final double interestAmount;
  final double totalAmount;
  final double remainingAmount;
  final int duration;
  final String requestDate;
  LoanDataDto({
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

  LoanData toEntity() {
    return LoanData(
      status: status,
      id: id,
      customerId: '',
      loanTypeId: LoanType(
        createdAt: '',
        currencies: [],
        description: '',
        id: '',
        image: '',
        name: loanType,
        updatedAt: '',
        interestRate: 0,
        maxDuration: 0,
        minDuration: 0,
        purpose: [''],
      ),
      loanPurpose: loanPurpose,
      currencyId: CurrencyId(
        country: '',
        createdAt: '',
        description: '',
        fiatCode: currency.fiatCode,
        id: currency.id,
        name: currency.name,
        updatedAt: '',
      ),
      dueDate: dueDate,
      requestedAmount: requestedAmount.toDouble(),
      interestAmount: interestAmount,
      totalAmount: totalAmount,
      remainingAmount: remainingAmount,
      duration: duration,
      requestDate: requestDate,
      createdAt: '',
      updatedAt: '',
    );
  }

  LoanDataDto copyWith({
    String? status,
    String? id,
    String? loanType,
    String? loanPurpose,
    CurrencyDto? currency,
    String? dueDate,
    double? requestedAmount,
    double? interestAmount,
    double? totalAmount,
    double? remainingAmount,
    int? duration,
    String? requestDate,
  }) {
    return LoanDataDto(
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

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'id': id,
      'loanType': loanType,
      'loanPurpose': loanPurpose,
      'currency': currency.toMap(),
      'dueDate': dueDate,
      'requestedAmount': requestedAmount,
      'interestAmount': interestAmount,
      'totalAmount': totalAmount,
      'remainingAmount': remainingAmount,
      'duration': duration,
      'requestDate': requestDate,
    };
  }

  factory LoanDataDto.fromMap(Map<String, dynamic> map) {
    return LoanDataDto(
      status: map['status'] ?? '',
      id: map['id'] ?? '',
      loanType: map['loantype'] ?? '',
      loanPurpose: map['loanpurpose'] ?? '',
      currency: CurrencyDto.fromMap(map['currency']),
      dueDate: map['duedate'] ?? '',
      requestedAmount: map['requestedamount']?.toInt() ?? 0,
      interestAmount: map['interestamount']?.toInt() ?? 0,
      totalAmount: map['totalamount']?.toInt() ?? 0,
      remainingAmount: map['remainingamount']?.toInt() ?? 0,
      duration: map['duration']?.toInt() ?? 0,
      requestDate: map['requestdate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanDataDto.fromJson(String source) =>
      LoanDataDto.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LoanDataDto(status: $status, id: $id, loanType: $loanType, '
        'loanPurpose: $loanPurpose, currency: $currency, dueDate: $dueDate, '
        'requestedAmount: $requestedAmount, interestAmount: $interestAmount, '
        'totalAmount: $totalAmount, remainingAmount: $remainingAmount, '
        'duration: $duration, requestDate: $requestDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoanDataDto &&
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
}
