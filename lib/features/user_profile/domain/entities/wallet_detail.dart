import 'package:loan_app/core/domain/entities/entities.dart';

class WalletDetail {
  WalletDetail({
    required this.balance,
    required this.createdDate,
    required this.id,
    required this.currencyId,
  });

  final double balance;
  final String createdDate;
  final String id;
  final CurrencyId currencyId;

  WalletDetail copyWith({
    double? balance,
    String? createdDate,
    String? id,
    CurrencyId? currencyId,
  }) {
    return WalletDetail(
      balance: balance ?? this.balance,
      createdDate: createdDate ?? this.createdDate,
      id: id ?? this.id,
      currencyId: currencyId ?? this.currencyId,
    );
  }

  @override
  String toString() {
    return 'WalletDetailDTO(balance: $balance, createdDate: $createdDate, '
        'id: $id, currencyId: $currencyId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletDetail &&
        other.balance == balance &&
        other.createdDate == createdDate &&
        other.id == id &&
        other.currencyId == currencyId;
  }

  @override
  int get hashCode {
    return balance.hashCode ^
        createdDate.hashCode ^
        id.hashCode ^
        currencyId.hashCode;
  }
}
