import 'package:flutter/foundation.dart';
import 'package:loan_app/features/loan_payment/domain/repositories/repositories.dart';
import 'package:loan_app/features/loan_payment/ioc/ioc.dart';
import 'package:loan_app/features/user_profile/domain/domain.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';
import 'package:loan_app/features/user_profile/ioc/ioc.dart';

class LoanPaymentProvider extends ChangeNotifier {
  Wallet? wallet;

  bool loading = false;

  bool paying = false;
  bool paid = false;

  String? errorMessage;

  final LoanPaymentRepo loanTypeRepository = LoanPaymentIOC.loanPaymentRepo();
  final WalletRepository walletRepository = UserIOC.walletRepo();

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

  Future<void> getWallet() async {
    setLoading(value: true);

    final result = await walletRepository.getWallet();
    result.fold(
      (error) => setErrorMessage(value: 'Could not get wallet'),
      (wallet) {
        this.wallet = wallet;
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
    paying = true;
    notifyListeners();
    final result = await loanTypeRepository.payLoan(
      amount: amount,
      currencyId: currencyId,
      loanId: loanId,
      password: password,
    );
    result.fold(
      (error) => setErrorMessage(value: 'Could not pay loan'),
      (paid) {
        this.paid = paid;
      },
    );
    paying = false;
    notifyListeners();
  }
}
