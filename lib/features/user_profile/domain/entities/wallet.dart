import 'package:flutter/foundation.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

class Wallet {
  Wallet({
    required this.id,
    required this.customerId,
    required this.walletDetail,
    required this.createdAt,
    required this.updatedAt,
  });
  final String id;
  final String customerId;
  final List<WalletDetail> walletDetail;
  final String createdAt;
  final String updatedAt;

  Wallet copyWith({
    String? id,
    String? customerId,
    List<WalletDetail>? walletDetail,
    String? createdAt,
    String? updatedAt,
  }) {
    return Wallet(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      walletDetail: walletDetail ?? this.walletDetail,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'Wallet(_id: $id, customerId: $customerId, walletDetail: '
        '$walletDetail, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Wallet &&
        other.id == id &&
        other.customerId == customerId &&
        listEquals(other.walletDetail, walletDetail) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customerId.hashCode ^
        walletDetail.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
