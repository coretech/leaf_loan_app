// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/features/user_profile/domain/domain.dart';

class WalletDto {
  WalletDto({
    required this.balance,
    required this.currency,
  });

  factory WalletDto.fromMap(Map<String, dynamic> map) {
    return WalletDto(
      balance: map['balance']?.toDouble() ?? 0.0,
      currency: CurrencyDto.fromMap(map['currency']),
    );
  }

  factory WalletDto.fromJson(String source) =>
      WalletDto.fromMap(json.decode(source));

  final double balance;
  final CurrencyDto currency;

  Wallet toEntity() {
    return Wallet(
      balance: balance,
      currency: currency.toEntity(),
    );
  }

  WalletDto copyWith({
    double? balance,
    CurrencyDto? currency,
  }) {
    return WalletDto(
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'currency': currency.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'WalletDto(balance: $balance, currency: $currency)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletDto &&
        other.balance == balance &&
        other.currency == currency;
  }

  @override
  int get hashCode => balance.hashCode ^ currency.hashCode;
}
