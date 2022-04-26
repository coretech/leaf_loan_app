// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:loan_app/core/data/data.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';

class LoanDataDto {
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

  factory LoanDataDto.fromMap(Map<String, dynamic> map) {
    return LoanDataDto(
      status: map['status'] ,
      id: map['id'] ,
      loanType: map['loanType'] ,
      loanPurpose: map['loanPurpose'] ,
      currency: CurrencyDto.fromMap(map['currency']),
      dueDate: map['dueDate'] ,
      requestedAmount: map['requestedAmount']?.toDouble() ,
      interestAmount: map['interestAmount']?.toDouble() ,
      totalAmount: map['totalAmount']?.toDouble() ,
      remainingAmount: map['remainingAmount']?.toDouble() ,
      duration: map['duration']?.toInt() ,
      requestDate: map['requestDate'] ,
    );
  }

  factory LoanDataDto.fromJson(String source) =>
      LoanDataDto.fromMap(json.decode(source));

  LoanData toEntity() {
    return LoanData(
      currency: currency.toEntity(),
      dueDate: dueDate,
      duration: duration,
      id: id,
      interestAmount: interestAmount,
      loanPurpose: loanPurpose,
      loanType: loanType,
      remainingAmount: remainingAmount,
      requestDate: requestDate,
      requestedAmount: requestedAmount,
      status: status,
      totalAmount: totalAmount,
    );
  }

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

  String toJson() => json.encode(toMap());

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
