import 'dart:convert';

import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/domain/entities/entities.dart';

class LoanNotificationPayloadDto {
  LoanNotificationPayloadDto({
    required this.loanId,
    required this.type,
    required this.paymentId,
  });

  factory LoanNotificationPayloadDto.fromMap(Map<String, dynamic> map) {
    return LoanNotificationPayloadDto(
      loanId: map['loanid'] ,
      type: map['type'] ,
      paymentId: map['paymentid'] ,
    );
  }

  factory LoanNotificationPayloadDto.fromJson(String source) =>
      LoanNotificationPayloadDto.fromMap(json.decode(source));

  LoanNotificationPayload toEntity() {
    return LoanNotificationPayload(
      loanId: loanId,
      type: notificationTypeFromString(type),
      paymentId: paymentId,
    );
  }

  final String loanId;
  final String type;
  final String paymentId;

  LoanNotificationPayloadDto copyWith({
    String? loanId,
    String? type,
    String? paymentId,
  }) {
    return LoanNotificationPayloadDto(
      loanId: loanId ?? this.loanId,
      type: type ?? this.type,
      paymentId: paymentId ?? this.paymentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loanid': loanId,
      'type': type,
      'paymentid': paymentId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'LoanNotificationPayloadDto(loanId: $loanId, type: $type, '
      'paymentId: $paymentId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoanNotificationPayloadDto &&
        other.loanId == loanId &&
        other.type == type &&
        other.paymentId == paymentId;
  }

  @override
  int get hashCode => loanId.hashCode ^ type.hashCode ^ paymentId.hashCode;
}
