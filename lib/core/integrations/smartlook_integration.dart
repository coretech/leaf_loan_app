import 'package:flutter_smartlook/flutter_smartlook.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/ioc/ioc.dart';

class SmartlookIntegration implements Recording {
  @override
  Future<void> init() async {
    final smartlookEnabled =
        IntegrationIOC.remoteConfig.getBool(RemoteConfigKeys.smartlookEnabled);
    const projectKey = String.fromEnvironment('SMARTLOOK_PROJECT_KEY');
    assert(
      !smartlookEnabled || projectKey.isNotEmpty,
      'Smartlook is enabled but api key is not provided',
    );
    if (smartlookEnabled) {
      final options = (SetupOptionsBuilder(projectKey)
            ..StartNewSession = true
            ..Fps = 1)
          .build();

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

  @override
  void dispose() {
    Smartlook.stopRecording();
  }
}
