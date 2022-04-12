import 'dart:convert';

import 'package:loan_app/core/domain/entities/entities.dart';

class NotificationPayloadDto {
  NotificationPayloadDto({
    required this.loanId,
    required this.type,
    required this.paymentId,
  });

  factory NotificationPayloadDto.fromMap(Map<String, dynamic> map) {
    return NotificationPayloadDto(
      loanId: map['loanid'] ?? '',
      type: map['type'] ?? '',
      paymentId: map['paymentId'] ?? '',
    );
  }

  factory NotificationPayloadDto.fromJson(String source) =>
      NotificationPayloadDto.fromMap(json.decode(source));

  NotificationPayload toEntity() {
    return NotificationPayload(
      loanId: loanId,
      type: notificationTypeFromString(type),
      paymentId: paymentId,
    );
  }

  final String loanId;
  final String type;
  final String paymentId;

  NotificationPayloadDto copyWith({
    String? loanId,
    String? type,
    String? paymentId,
  }) {
    return NotificationPayloadDto(
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
  String toString() => 'NotificationPayloadDto(loanId: $loanId, type: $type, '
      'paymentId: $paymentId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationPayloadDto &&
        other.loanId == loanId &&
        other.type == type &&
        other.paymentId == paymentId;
  }

  @override
  int get hashCode => loanId.hashCode ^ type.hashCode ^ paymentId.hashCode;
}

NotificationType notificationTypeFromString(String type) {
  switch (type) {
    case 'payment':
      return NotificationType.payment;
    case 'loan':
      return NotificationType.loanStatusUpdate;
    default:
      return NotificationType.loanStatusUpdate;
  }
}
