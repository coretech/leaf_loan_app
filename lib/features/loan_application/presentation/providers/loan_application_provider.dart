import 'package:flutter/foundation.dart';
import 'package:loan_app/features/loan_application/domain/domain.dart';
import 'package:loan_app/features/loan_application/ioc/ioc.dart';

class LoanApplicationProvider extends ChangeNotifier {
  final LoanApplicationRepository loanTypeRepository =
      LoanApplicationIOC.loanApplicationRepo();
  bool loading = false;
  bool completed = false;
  String? errorMessage;

  void setLoading({required bool value}) {
    loading = value;
    notifyListeners();
  }

  void setErrorMessage(String? value) {
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

  Future<void> apply({
    required double amount,
    required String currencyId,
    required int duration,
    required String loanPurpose,
    required String loanTypeId,
    required String pinCode,
  }) async {
    setLoading(value: true);
    final resultEither = await loanTypeRepository.apply(
      amount: amount,
      currencyId: currencyId,
      duration: duration,
      loanPurpose: loanPurpose,
      loanTypeId: loanTypeId,
      password: pinCode,
    );

    resultEither.fold(
      (l) => setErrorMessage("Couldn't complete application"),
      (r) {
        completed = true;
      },
    );
    setLoading(value: false);
  }
}
