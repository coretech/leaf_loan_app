import 'package:flutter/cupertino.dart';
import 'package:loan_app/features/loan_application/domain/domain.dart';
import 'package:loan_app/features/loan_application/ioc/ioc.dart';

class LoanApplicationProvider extends ChangeNotifier {
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
    notifyListeners();
  }

  List<LoanType> loanTypes = [];

  bool get hasLoanTypes => loanTypes.isNotEmpty;

  bool get canShowTypes => hasLoanTypes && !loading;

  Future<void> getLoanTypes() async {
    clear();
    setLoading(value: true);
    final loanTypesEither = await loanTypeRepository.getLoanTypes();
    loanTypes = loanTypesEither.fold(
      (l) {
        setErrorMessage(value: "Couldn't fetch loan types");
        return [];
      },
      (r) => r,
    );
    setLoading(value: false);
  }
}
