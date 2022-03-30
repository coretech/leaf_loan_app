import 'package:loan_app/core/domain/domain.dart';

class Wallet {
  Wallet({
    required this.balance,
    required this.currency,
  });

  final double balance;
  final Currency currency;

  Wallet copyWith({
    double? balance,
    Currency? currency,
  }) {
    return Wallet(
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Wallet &&
        other.balance == balance &&
        other.currency == currency;
  }

  @override
  int get hashCode => balance.hashCode ^ currency.hashCode;

  @override
  String toString() => 'Wallet(balance: $balance, currency: $currency)';
}
