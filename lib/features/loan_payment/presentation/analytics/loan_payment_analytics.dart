import 'package:loan_app/core/ioc/ioc.dart';

class LoanPaymentAnalytics {
  static void loanPaymentPayButtonTapped() {
    IntegrationIOC.analytics.logEvent('loan_payment_pay_button_tapped');
  }

  static void loanPaymentSubmitted() {
    IntegrationIOC.analytics.logEvent('loan_payment_submitted');
  }
}
