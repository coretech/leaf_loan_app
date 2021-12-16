import 'package:flutter/foundation.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:loan_app/features/loan_history/ioc/ioc.dart';
import 'package:loan_app/features/loan_payment/domain/domain.dart';
import 'package:loan_app/features/loan_payment/ioc/ioc.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    _eventBus.on<LoanApplicationEvent>().listen((event) async {
      if (event == LoanApplicationEvent.success) {
        await getActiveLoan();
      }
    });

    _eventBus.on<LoanPaymentSuccess>().listen((event) async {
      final updatedLoan = event.loan;
      await setActiveLoan(
        activeLoan!.copyWith(
          remainingAmount: updatedLoan.remainingAmount,
        ),
      );
    });
  }

  bool loading = false;
  bool loadingPayments = false;

  String? errorMessage;

  List<Payment> payments = [];
  LoanData? activeLoan;
  bool paymentsLoaded = false;

  final _loanPaymentRepo = LoanPaymentIOC.loanPaymentRepo();
  final _loanHistoryRepo = LoanHistoryIOC.loanHistoryRepo();

  final _eventBus = IntegrationIOC.eventBus();

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

  Future<void> setActiveLoan(LoanData loan) async {
    activeLoan = loan;
    notifyListeners();
    await getPayments();
  }

  Future<void> getActiveLoan() async {
    await Future.delayed(Duration.zero);
    clear();
    setLoading(value: true);
    final _loanResult = await _loanHistoryRepo.getActiveLoan();
    _loanResult.fold(
      (error) => setErrorMessage(value: 'Error getting active loan'),
      (loanData) async {
        activeLoan = loanData;
        notifyListeners();
        await getPayments();
      },
    );
    setLoading(value: false);
  }

  Future<void> getPayments() async {
    loadingPayments = true;
    notifyListeners();
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
    loadingPayments = false;
    paymentsLoaded = true;
    setLoading(value: false);
    notifyListeners();
  }
}
