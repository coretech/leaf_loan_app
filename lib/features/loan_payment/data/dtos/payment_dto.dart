// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:loan_app/core/data/data.dart';
import 'package:loan_app/features/loan_payment/domain/entities/entities.dart';

class PaymentDto {
  PaymentDto({
    required this.status,
    required this.id,
    required this.loanId,
    required this.principalAmount,
    required this.interestAmount,
    required this.paymentAmount,
    required this.currency,
    required this.createdAt,
  });

  factory PaymentDto.fromMap(Map<String, dynamic> map) {
    return PaymentDto(
      status: map['status'] ,
      id: map['id'] ,
      loanId: map['loanId'] ,
      principalAmount: map['principalAmount']?.toDouble() ?? 0.0,
      interestAmount: map['interestAmount']?.toDouble() ?? 0.0,
      paymentAmount: map['paymentAmount']?.toDouble() ?? 0.0,
      currency: CurrencyDto.fromMap(map['currency']),
      createdAt: map['createdAt'] ,
    );
  }

  factory PaymentDto.fromJson(String source) =>
      PaymentDto.fromMap(json.decode(source));

  final String status;
  final String id;
  final String loanId;
  final double principalAmount;
  final double interestAmount;
  final double paymentAmount;
  final CurrencyDto currency;
  final String createdAt;

  Payment toEntity() {
    return Payment(
      status: status,
      id: id,
      customerId: '',
      principalAmount: principalAmount,
      interestAmount: interestAmount,
      paymentAmount: paymentAmount,
      createdAt: createdAt,
      updatedAt: '',
    );
  }

  PaymentDto copyWith({
    String? status,
    String? id,
    String? loanId,
    double? principalAmount,
    double? interestAmount,
    double? paymentAmount,
    CurrencyDto? currency,
    String? createdAt,
  }) {
    return PaymentDto(
      status: status ?? this.status,
      id: id ?? this.id,
      loanId: loanId ?? this.loanId,
      principalAmount: principalAmount ?? this.principalAmount,
      interestAmount: interestAmount ?? this.interestAmount,
      paymentAmount: paymentAmount ?? this.paymentAmount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'id': id,
      'loanId': loanId,
      'principalAmount': principalAmount,
      'interestAmount': interestAmount,
      'paymentAmount': paymentAmount,
      'currency': currency.toMap(),
      'createdAt': createdAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'PaymentDto(status: $status, id: $id, loanId: $loanId, '
        'principalAmount: $principalAmount, interestAmount: $interestAmount, '
        'paymentAmount: $paymentAmount, currency: $currency, '
        'createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentDto &&
        other.status == status &&
        other.id == id &&
        other.loanId == loanId &&
        other.principalAmount == principalAmount &&
        other.interestAmount == interestAmount &&
        other.paymentAmount == paymentAmount &&
        other.currency == currency &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        id.hashCode ^
        loanId.hashCode ^
        principalAmount.hashCode ^
        interestAmount.hashCode ^
        paymentAmount.hashCode ^
        currency.hashCode ^
        createdAt.hashCode;
  }
}
