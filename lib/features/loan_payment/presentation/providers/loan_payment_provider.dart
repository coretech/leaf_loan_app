import 'package:flutter/foundation.dart';
import 'package:loan_app/core/events/events.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/loan_payment/ioc/ioc.dart';
import 'package:loan_app/features/user_profile/domain/domain.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';
import 'package:loan_app/features/user_profile/ioc/ioc.dart';

class LoanPaymentProvider extends ChangeNotifier {
  List<Wallet> wallets = [];

  bool loading = false;

  bool paying = false;
  bool paid = false;

  String? errorMessage;
  String? walletErrorMessage;

  final _loanTypeRepository = LoanPaymentIOC.loanPaymentRepo();
  final _walletRepository = UserIOC.walletRepo();
  final _eventBus = IntegrationIOC.eventBus;

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
    walletErrorMessage = null;
    notifyListeners();
  }

  Future<void> getWallet() async {
    clear();
    setLoading(value: true);

    final result = await _walletRepository.getWallet();
    result.fold(
      (error) {
        walletErrorMessage =
            "We couldn't fetch wallet balance. Please try again.";
      },
      (wallets) {
        this.wallets = wallets;
      },
    );

    setLoading(value: false);
    notifyListeners();
  }

  Future<void> payLoan({
    required double amount,
    required String currencyId,
    required String loanId,
    required String password,
  }) async {
    clear();
    paying = true;
    notifyListeners();
    final result = await _loanTypeRepository.payLoan(
      amount: amount,
      currencyId: currencyId,
      loanId: loanId,
      password: password,
    );
    result.fold(
      (error) => setErrorMessage(
        value: "Your payment didn't go through. Please try again.",
      ),
      (payment) {
        _eventBus.fire(LoanPaymentSuccess(payment: payment));
        paid = true;
      },
    );
    paying = false;
    notifyListeners();
  }
}
