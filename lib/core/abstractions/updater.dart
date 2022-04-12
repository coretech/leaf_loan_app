abstract class Updater {
  Future<UpdateInfo> checkForUpdate();
  Future<void> performImmediateUpdate();
  Future<void> startFlexibleUpdate();
  Future<void> completeFlexibleUpdate();
}

class UpdateInfo {
  UpdateInfo({
    this.availableVersionCode,
    this.clientVersionStalenessInDays,
    required this.immediateUpdate,
  });
  final int? availableVersionCode;
  final int? clientVersionStalenessInDays;
  final bool immediateUpdate;
}
