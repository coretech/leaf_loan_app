import 'package:flutter_smartlook/flutter_smartlook.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';

class SmartlookIntegration implements Recording {
  @override
  Future<void> init() async {
    const smartlookEnabled = String.fromEnvironment('SMARTLOOK_ENABLED');
    const projectKey = String.fromEnvironment('SMARTLOOK_PROJECT_KEY');
    assert(
      smartlookEnabled != 'true' || projectKey.isNotEmpty,
      'Smartlook is enabled but api key is not provided',
    );
    if (smartlookEnabled == 'true') {
      final options =
          (SetupOptionsBuilder(projectKey)..StartNewSession = true).build();

      await Smartlook.setupAndStartRecording(options);
      await Smartlook.setEventTrackingMode(EventTrackingMode.FULL_TRACKING);
      await Smartlook.getDashboardSessionUrl(true);
    }
  }

  @override
  Future<void> setUserInfo(String username) async {
    await Smartlook.setUserIdentifier(
      username,
    );
  }
}
