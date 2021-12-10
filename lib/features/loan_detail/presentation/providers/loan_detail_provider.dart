import 'package:flutter/foundation.dart';
import 'package:loan_app/features/loan_payment/domain/domain.dart';
import 'package:loan_app/features/loan_payment/ioc/ioc.dart';

class LoanDetailProvider extends ChangeNotifier {
  bool loading = false;

  String? errorMessage;

  List<Payment> payments = [];
  bool paymentsLoaded = false;

  final _loanPaymentRepo = LoanPaymentIOC.loanPaymentRepo();

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

  Future<void> getPayments(String loanId) async {
    clear();
    setLoading(value: true);
    final _loansPayments =
        await _loanPaymentRepo.getLoanPayments(loanId: loanId);
    _loansPayments.fold(
      (l) => setErrorMessage(value: 'Some error occurred while loading'),
      (r) {
        payments = r;
      },
    );
    paymentsLoaded = true;
    setLoading(value: false);
    notifyListeners();
  }
}
