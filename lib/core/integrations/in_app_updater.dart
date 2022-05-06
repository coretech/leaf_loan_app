import 'package:in_app_update/in_app_update.dart';
import 'package:loan_app/core/core.dart';
import 'package:package_info/package_info.dart';

class InAppUpdater implements Updater {
  final remoteConfiguration = IntegrationIOC.remoteConfig;

  @override
  Future<UpdateInfo> checkForUpdate() async {
    final appUpdateInfo = await InAppUpdate.checkForUpdate();
    final latestSupportedBuild =
        remoteConfiguration.getInt(RemoteConfigKeys.latestSupportedBuild);
    final packageInfo = await PackageInfo.fromPlatform();
    final currentBuild = int.parse(packageInfo.buildNumber);

    final updateInfo = UpdateInfo(
      immediateUpdate: currentBuild < latestSupportedBuild,
      availableVersionCode: appUpdateInfo.availableVersionCode,
      clientVersionStalenessInDays: appUpdateInfo.clientVersionStalenessDays,
    );
    return updateInfo;
  }

  @override
  Future<void> completeFlexibleUpdate() async {
    await InAppUpdate.completeFlexibleUpdate();
  }

  @override
  Future<void> performImmediateUpdate() async {
    await InAppUpdate.performImmediateUpdate();
  }

  @override
  Future<void> startFlexibleUpdate() async {
    await InAppUpdate.startFlexibleUpdate();
  }
}
