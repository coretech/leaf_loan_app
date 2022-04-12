import 'package:loan_app/core/ioc/ioc.dart';

class UserProfileAnalytics {
  static void logEditProfileTapped(String? userId) {
    IntegrationIOC.analytics.logEvent(
      'edit_profile_tapped',
      parameters: <String, dynamic>{
        'user_id': userId ?? 'Not Loaded Yet',
      },
    );
  }

  static void logLogOutTapped(String? username) {
    IntegrationIOC.analytics.logLogout(username);
  }
}
