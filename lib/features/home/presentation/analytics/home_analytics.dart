import 'package:loan_app/core/core.dart';

class HomeAnalytics {
  static void homeLoanCardTapped() {
    IntegrationIOC.analytics().logEvent('home_loan_card_tapped');
  }

  static void homeShowMoreTapped() {
    IntegrationIOC.analytics().logEvent('home_show_more_tapped');
  }
}
