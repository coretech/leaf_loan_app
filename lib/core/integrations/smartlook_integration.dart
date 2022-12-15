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
    final smartlook = Smartlook.instance;

    await smartlook.start();
    await smartlook.preferences.setProjectKey(projectKey);
  }

  @override
  Future<void> setUserInfo(String username) async {
    await Smartlook.instance.user.setIdentifier(
      username,
    );
  }

  @override
  void dispose() {
    Smartlook.instance.stop();
  }
}
