import 'package:loan_app/core/ioc/ioc.dart';

class LoanDetailAnalytics {
  static void logBigPayButtonTapped() {
    IntegrationIOC.analytics.logEvent('loan_detail_big_pay_button_tapped');
  }

  static void logSmallPayButtonTapped() {
    IntegrationIOC.analytics.logEvent('loan_detail_small_pay_button_tapped');
  }
}
