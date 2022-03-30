import 'dart:convert';

import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/domain/entities/entities.dart';
import 'package:loan_app/features/user_profile/domain/domain.dart';

class WalletDto {
  final double balance;
  final CurrencyDto currency;
  WalletDto({
    required this.balance,
    required this.currency,
  });

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

  factory WalletDto.fromMap(Map<String, dynamic> map) {
    return WalletDto(
      balance: map['balance']?.toDouble() ?? 0.0,
      currency: CurrencyDto.fromMap(map['currency']),
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletDto.fromJson(String source) =>
      WalletDto.fromMap(json.decode(source));

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
