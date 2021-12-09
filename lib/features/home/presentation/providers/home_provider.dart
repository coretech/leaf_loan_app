import 'package:flutter/foundation.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:loan_app/features/loan_history/ioc/ioc.dart';
import 'package:loan_app/features/loan_payment/domain/domain.dart';
import 'package:loan_app/features/loan_payment/ioc/ioc.dart';

class HomeProvider extends ChangeNotifier {
  bool loading = false;

  String? errorMessage;

  List<Payment> payments = [];
  LoanData? activeLoan;
  bool paymentsLoaded = false;

  final _loanPaymentRepo = LoanPaymentIOC.loanPaymentRepo();
  final _loanHistoryRepo = LoanHistoryIOC.loanHistoryRepo();

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

  Future<void> getActiveLoan() async {
    clear();
    setLoading(value: true);
    final _loansResult = await _loanHistoryRepo.getLoans();
    await _loansResult.fold(
      (l) {
        setErrorMessage(value: 'Some error occurred while loading');
        setLoading(value: false);
      },
      (loans) async {
        for (final loan in loans) {
          if (loanStatusFromString(loan.status) == LoanStatus.approved) {
            activeLoan = loan;
            setLoading(value: false);
            await getPayments();
          }
        }
      },
    );
  }

  Future<void> getPayments() async {
    clear();
    setLoading(value: true);
    if (activeLoan != null) {
      final _loansPayments =
          await _loanPaymentRepo.getLoanPayments(loanId: activeLoan!.id);
      _loansPayments.fold(
        (l) => setErrorMessage(value: 'Some error occurred while loading'),
        (r) {
          payments = r;
        },
      );
    }
    paymentsLoaded = true;
    setLoading(value: false);
    notifyListeners();
  }
}
