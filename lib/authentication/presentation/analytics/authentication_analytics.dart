import 'package:loan_app/core/ioc/ioc.dart';

class AuthenticationAnalytics {
  static void logSignIn(String username, String method) {
    IntegrationIOC.analytics.logLogin(username, method);
    IntegrationIOC.logger().setUserId(username);
    IntegrationIOC.recording.setUserInfo(username);
  }

  static void logLeafWalletButtonTapped() {
    IntegrationIOC.analytics.logEvent(
      'auth_page_leaf_wallet_button_tapped',
    );
  }

  static void logSignUpTapped() {
    IntegrationIOC.analytics.logEvent(
      'sign_up_tapped',
    );
  }
}
