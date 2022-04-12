import 'package:loan_app/core/ioc/ioc.dart';

class LoanApplicationAnalytics {
  static void amountFieldUsed() {
    IntegrationIOC.analytics.logEvent('loan_application_amount_field_used');
  }

  static void interactedWithPage() {
    IntegrationIOC.analytics.logEvent('interacted_with_loan_application_page');
  }

  static void addCurrencyTapped() {
    IntegrationIOC.analytics.logEvent('add_currency_tapped');
  }

  static void loanApplicationSubmitButtonTapped() {
    IntegrationIOC.analytics.logEvent('loan_application_submit_button_tapped');
  }

  static void loanApplicationSubmitted() {
    IntegrationIOC.analytics.logEvent('loan_application_submitted');
  }

  static void sliderUsed() {
    IntegrationIOC.analytics.logEvent('loan_application_slider_used');
  }
}
