import 'package:flutter/foundation.dart';
import 'package:loan_app/features/loan_application/ioc/ioc.dart';

class LoanCancellationProvider extends ChangeNotifier {
  final _loanApplicationRepo = LoanApplicationIOC.loanApplicationRepo();

  bool loading = false;
  bool cancellationStatus = false;

  String? errorMessage;

  void setLoading({required bool value}) {
    loading = value;
    notifyListeners();
  }

  void setCancellationStatus({required bool value}) {
    cancellationStatus = value;
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

  Future<void> cancelLoanApplication(String loanId, String password) async {
    clear();
    setLoading(value: true);
    final result =
        await _loanApplicationRepo.cancel(loanId: loanId, password: password);
    result.fold(
      (error) => setErrorMessage(value: 'Error canceling loan application'),
      (value) {
        setLoading(value: false);
        setCancellationStatus(value: true);
      },
    );
    setLoading(value: false);
    notifyListeners();
  }
}
