import 'package:loan_app/core/domain/entities/entities.dart';

abstract class NotificationEvent {}

class PaymentNotificationEvent implements NotificationEvent {
  PaymentNotificationEvent({
    required this.payload,
  });

  final LoanNotificationPayload payload;
}

class LoanNotificationEvent implements NotificationEvent {
  LoanNotificationEvent({
    required this.payload,
  });

  final LoanNotificationPayload payload;
}
