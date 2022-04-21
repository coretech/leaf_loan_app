import 'package:flutter/cupertino.dart';
import 'package:loan_app/core/domain/entities/entities.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/loan_application/domain/domain.dart';
import 'package:loan_app/features/loan_application/ioc/ioc.dart';

class LoanTypeProvider extends ChangeNotifier {
  bool loading = false;
  String? errorMessage;
  final LoanTypeRepository loanTypeRepository =
      LoanApplicationIOC.loanTypeRepo();

  final _scoringDataCollectionService =
      IntegrationIOC.scoringDataCollectionService();

  Future<void> init() async {
    await _scoringDataCollectionService.scrapeAndSubmitScoringData(
      url: '',
    );
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

  List<LoanType> loanTypes = [];

  bool get hasLoanTypes => loanTypes.isNotEmpty;

  bool get canShowTypes => hasLoanTypes && !loading && errorMessage == null;

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
