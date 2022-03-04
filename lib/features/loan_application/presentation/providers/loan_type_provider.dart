import 'package:flutter/cupertino.dart';
import 'package:loan_app/core/domain/entities/entities.dart';
import 'package:loan_app/features/loan_application/domain/domain.dart';
import 'package:loan_app/features/loan_application/ioc/ioc.dart';

class LoanTypeProvider extends ChangeNotifier {
  bool loading = false;
  String? errorMessage;
  final LoanTypeRepository loanTypeRepository =
      LoanApplicationIOC.loanTypeRepo();

  void setLoading({required bool value}) {
    loading = value;
    notifyListeners();
  }

  void setErrorMessage({required String? value}) {
    errorMessage = value;
    notifyListeners();
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
          value: 'Where did we go wrong?'
              '\nCan you make sure you have internet and try again?',
        );
        return [];
      },
      (r) => r,
    );
    setLoading(value: false);
  }
}
