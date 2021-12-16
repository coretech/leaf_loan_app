import 'package:flutter/foundation.dart';
import 'package:loan_app/core/events/events.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/features/loan_payment/domain/domain.dart';
import 'package:loan_app/features/loan_payment/ioc/ioc.dart';

class LoanDetailProvider extends ChangeNotifier {
  LoanDetailProvider() {
    _eventBus.on<LoanPaymentSuccess>().listen((event) async {
      final updatedLoan = event.loan;
      setLoan(
        loan!.copyWith(
          remainingAmount: updatedLoan.remainingAmount,
        ),
      );
      await getPayments();
    });
  }

  final _loanPaymentRepo = LoanPaymentIOC.loanPaymentRepo();

  final _eventBus = IntegrationIOC.eventBus();

  bool loading = false;

  String? errorMessage;

  List<Payment> payments = [];
  bool paymentsLoaded = false;
  LoanData? loan;

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

  void setLoan(LoanData loan) {
    this.loan = loan;
    notifyListeners();
  }

  Future<void> getPayments() async {
    final loanId = loan?.id ?? '';
    clear();
    setLoading(value: true);
    final _loansPayments =
        await _loanPaymentRepo.getLoanPayments(loanId: loanId);
    _loansPayments.fold(
      (error) => setErrorMessage(value: 'Some error occurred while loading'),
      (payments) {
        this.payments = payments.reversed.toList();
      },
    );
    paymentsLoaded = true;
    setLoading(value: false);
    notifyListeners();
  }
}
