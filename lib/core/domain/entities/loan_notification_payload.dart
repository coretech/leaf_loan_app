import 'package:loan_app/core/domain/domain.dart';

class LoanNotificationPayload {
  LoanNotificationPayload({
    required this.loanId,
    this.paymentId,
    required this.type,
  });

  final String loanId;
  final String? paymentId;
  final NotificationType type;
}
