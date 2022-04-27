import 'package:flutter/foundation.dart';
import 'package:loan_app/core/events/events.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/features/loan_history/ioc/ioc.dart';
import 'package:loan_app/features/loan_payment/domain/domain.dart';
import 'package:loan_app/features/loan_payment/ioc/ioc.dart';

class LoanDetailProvider extends ChangeNotifier {
  LoanDetailProvider() {
    _eventBus.on<LoanPaymentSuccess>().listen((event) async {
      await getPayments();
    });

    _eventBus.on<NotificationEvent>().listen((event) async {
      var loanId = '';
      if (event is PaymentNotificationEvent) {
        loanId = event.payload.loanId;
      } else if (event is LoanNotificationEvent) {
        loanId = event.payload.loanId;
      }
      await updateLoanDetail(loanId);
    });
  }

  final _loanPaymentRepo = LoanPaymentIOC.loanPaymentRepo();
  final _loanHistoryRepo = LoanHistoryIOC.loanHistoryRepo();

  final _eventBus = IntegrationIOC.eventBus;

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

  Future<void> updateLoanDetail(String loanId) async {
    final loanEither = await _loanHistoryRepo.getLoanById(loanId);

    await loanEither.fold(
      (_) async => getPayments(),
      (updatedLoan) async {
        setLoan(
          loan!.copyWith(
            remainingAmount: updatedLoan.remainingAmount,
          ),
        );
        await getPayments();
      },
    );
  }

  Future<void> getPayments() async {
    if (loan != null) {
      final loanId = loan!.id;
      clear();
      setLoading(value: true);
      final _loansPayments =
          await _loanPaymentRepo.getLoanPayments(loanId: loanId);
      _loansPayments.fold(
        (error) => setErrorMessage(
          value: "We couldn't get the payments. Please try again.",
        ),
        (payments) {
          this.payments = payments.reversed.toList();
        },
      );
      paymentsLoaded = true;
      setLoading(value: false);
      notifyListeners();
    }
  }
}
