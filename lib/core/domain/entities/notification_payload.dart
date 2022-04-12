import 'package:loan_app/core/domain/domain.dart';

class NotificationPayload {
  NotificationPayload({
    required this.path,
    required this.type,
  });
  final String path;
  final NotificationType type;
}
