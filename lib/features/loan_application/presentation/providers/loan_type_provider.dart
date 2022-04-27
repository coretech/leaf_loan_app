import 'package:flutter/cupertino.dart';
import 'package:loan_app/core/domain/entities/entities.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_application/domain/domain.dart';
import 'package:loan_app/features/loan_application/ioc/ioc.dart';
import 'package:permission_handler/permission_handler.dart';

class LoanTypeProvider extends ChangeNotifier {
  bool loading = false;

  bool checkingPermissions = true;

  String? errorMessage;

  List<LoanType> loanTypes = [];

  List<Permission> deniedPermissions = [];

  bool get hasLoanTypes => loanTypes.isNotEmpty;

  bool get canShowTypes => hasLoanTypes && !loading && errorMessage == null;

  bool get permissionsGranted =>
      !checkingPermissions && deniedPermissions.isEmpty;

  final LoanTypeRepository loanTypeRepository =
      LoanApplicationIOC.loanTypeRepo();

  final _scoringDataCollectionService =
      IntegrationIOC.scoringDataCollectionService();

  Future<void> init() async {
    await Future.delayed(Duration.zero);
    checkingPermissions = true;
    notifyListeners();

    const permissions = [
      Permission.calendar,
      Permission.contacts,
      Permission.storage,
      Permission.mediaLibrary,
    ];
    final requestResults = await PermissionsUtil.request(permissions);

    deniedPermissions = MapUtil.getMatching(
      requestResults,
      {
        PermissionStatus.denied,
        PermissionStatus.permanentlyDenied,
      },
    );

    checkingPermissions = false;
    notifyListeners();
    if (permissionsGranted) {
      await _scoringDataCollectionService.scrapeAndSubmitScoringData(
        url: '',
      );
    }
  }

  void setLoading({required bool value}) {
    loading = value;
    notifyListeners();
  }

  // ignore: use_setters_to_change_properties
  void setErrorMessage({required String? value}) {
    errorMessage = value;
  }

  void clearErrorMessage() {
    errorMessage = null;
    notifyListeners();
  }

  void clear() {
    loading = false;
    errorMessage = null;
  }

  Future<void> getLoanTypes() async {
    await Future.delayed(Duration.zero);
    clear();
    setLoading(value: true);
    final loanTypesEither = await loanTypeRepository.getLoanTypes();
    loanTypes = loanTypesEither.fold(
      (l) {
        setErrorMessage(
          value: genericErrorMessage,
        );
        return [];
      },
      (r) => r,
    );
    setLoading(value: false);
  }

  String genericErrorMessage = 'Where did we go wrong?'
      '\nCan you make sure you have internet and try again?';
}
