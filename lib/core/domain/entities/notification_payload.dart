class NotificationPayload {
  NotificationPayload({
    required this.loanId,
    this.paymentId,
    required this.type,
  });

  final String loanId;
  final String? paymentId;
  final NotificationType type;
}

enum NotificationType { payment, loanStatusUpdate }
