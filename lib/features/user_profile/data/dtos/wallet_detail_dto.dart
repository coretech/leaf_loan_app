import 'dart:convert';

import 'package:loan_app/core/data/data.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class WalletDetailDto {
  WalletDetailDto({
    required this.balance,
    required this.createddate,
    required this.id,
    required this.currencyid,
  });

  factory WalletDetailDto.fromMap(Map<String, dynamic> map) {
    return WalletDetailDto(
      balance: double.parse(map['balance'].toString()),
      createddate: map['createddate'],
      id: map['_id'],
      currencyid: CurrencyIdDto.fromMap(map['currencyid']),
    );
  }

  factory WalletDetailDto.fromJson(String source) =>
      WalletDetailDto.fromMap(json.decode(source));

  final double balance;
  final String createddate;
  final String id;
  final CurrencyIdDto currencyid;

  WalletDetail toEntity() {
    return WalletDetail(
      balance: balance,
      createdDate: createddate,
      id: id,
      currencyId: currencyid.toEntity(),
    );
  }

  WalletDetailDto copyWith({
    double? balance,
    String? createddate,
    String? id,
    CurrencyIdDto? currencyid,
  }) {
    return WalletDetailDto(
      balance: balance ?? this.balance,
      createddate: createddate ?? this.createddate,
      id: id ?? this.id,
      currencyid: currencyid ?? this.currencyid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'createddate': createddate,
      'id': id,
      'currencyid': currencyid.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'WalletDetailDTO(balance: $balance, createddate: $createddate, '
        '_id: $id, currencyid: $currencyid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletDetailDto &&
        other.balance == balance &&
        other.createddate == createddate &&
        other.id == id &&
        other.currencyid == currencyid;
  }

  @override
  int get hashCode {
    return balance.hashCode ^
        createddate.hashCode ^
        id.hashCode ^
        currencyid.hashCode;
  }
}
