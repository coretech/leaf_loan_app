import 'package:loan_app/core/ioc/ioc.dart';

class LoanHistoryAnalytics {
  static void inactiveHistoryCardTapped() {
    IntegrationIOC.analytics.logEvent('inactive_loan_history_card_tapped');
  }
}
