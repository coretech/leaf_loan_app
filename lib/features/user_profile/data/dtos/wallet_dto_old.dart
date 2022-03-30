import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:loan_app/features/user_profile/data/dtos/dtos.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class WalletDto {
  WalletDto({
    required this.id,
    required this.customerid,
    required this.walletdetail,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WalletDto.fromMap(Map<String, dynamic> map) {
    return WalletDto(
      id: map['_id'],
      customerid: map['customerid'],
      walletdetail: List<WalletDetailDto>.from(
        // ignore: avoid_dynamic_calls
        map['walletdetail'].map((x) => WalletDetailDto.fromMap(x)),
      ),
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  factory WalletDto.fromJson(String source) =>
      WalletDto.fromMap(json.decode(source));

  final String id;
  final String customerid;
  final List<WalletDetailDto> walletdetail;
  final String createdAt;
  final String updatedAt;

  Wallet toEntity() {
    return Wallet(
      id: id,
      customerId: customerid,
      walletDetail: walletdetail.map((x) => x.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  WalletDto copyWith({
    String? id,
    String? customerid,
    List<WalletDetailDto>? walletdetail,
    String? createdAt,
    String? updatedAt,
  }) {
    return WalletDto(
      id: id ?? this.id,
      customerid: customerid ?? this.customerid,
      walletdetail: walletdetail ?? this.walletdetail,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt,
      'customerid': customerid,
      'updatedAt': updatedAt,
      'walletdetail': walletdetail.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'WalletDto(_id: $id, customerid: $customerid, walletdetail: '
        '$walletdetail, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WalletDto &&
        other.id == id &&
        other.customerid == customerid &&
        listEquals(other.walletdetail, walletdetail) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerid.hashCode ^
        walletdetail.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
