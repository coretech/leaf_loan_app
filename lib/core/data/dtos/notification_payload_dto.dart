import 'dart:convert';

import 'package:loan_app/core/domain/domain.dart';

class NotificationPayloadDto {
  NotificationPayloadDto({
    required this.path,
    required this.type,
  });

  factory NotificationPayloadDto.fromMap(Map<String, dynamic> map) {
    return NotificationPayloadDto(
      path: map['path'] ,
      type: map['type'] ,
    );
  }

  factory NotificationPayloadDto.fromJson(String source) =>
      NotificationPayloadDto.fromMap(json.decode(source));

  NotificationPayload toEntity() {
    return NotificationPayload(
      path: path,
      type: notificationTypeFromString(type),
    );
  }

  final String path;
  final String type;

  NotificationPayloadDto copyWith({
    String? path,
    String? type,
  }) {
    return NotificationPayloadDto(
      path: path ?? this.path,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'type': type,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'NotificationPayloadDto(path: $path, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationPayloadDto &&
        other.path == path &&
        other.type == type;
  }

  @override
  int get hashCode => path.hashCode ^ type.hashCode;
}

NotificationType notificationTypeFromString(String type) {
  switch (type) {
    case 'payment':
      return NotificationType.payment;
    case 'loan':
      return NotificationType.loanStatusUpdate;
    case 'appUpdate':
      return NotificationType.appUpdate;
    case 'navigationWithoutPayload':
      return NotificationType.navigationWithoutPayload;
    default:
      return NotificationType.loanStatusUpdate;
  }
}
