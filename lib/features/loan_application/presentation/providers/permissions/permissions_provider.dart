import 'package:flutter/foundation.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_application/presentation/presentation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsProvider extends ChangeNotifier {
  PermissionsState state = PermissionsInitial();

  Future<void> request() async {
    try {
      state = RequestingPermissions();
      notifyListeners();

      const permissions = [
        Permission.calendar,
        Permission.contacts,
        Permission.storage,
        Permission.mediaLibrary,
      ];
      final requestResults = await PermissionsUtil.request(permissions);

      final deniedPermissions = MapUtil.getMatching(
        requestResults,
        {
          PermissionStatus.denied,
          PermissionStatus.permanentlyDenied,
        },
      );

      if (deniedPermissions.isEmpty) {
        state = PermissionsGranted();
      } else {
        state = PermissionsDenied(deniedPermissions);
      }

      notifyListeners();
      // if (permissionsGranted) {
      //   await _scoringDataCollectionService.scrapeAndSubmitScoringData(
      //     url: '',
      //   );
      // }
    } catch (e) {
      state = PermissionsError(
        'Some error occurred while requesting permissions',
      );
      notifyListeners();
    }
  }
}
