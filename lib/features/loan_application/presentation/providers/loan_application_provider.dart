import 'package:flutter/foundation.dart';
import 'package:loan_app/core/events/events.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/loan_application/ioc/ioc.dart';

class LoanApplicationProvider extends ChangeNotifier {
  final _loanTypeRepository = LoanApplicationIOC.loanApplicationRepo();
  final _eventBus = IntegrationIOC.eventBus;

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
    final resultEither = await _loanTypeRepository.apply(
      amount: amount,
      currencyId: currencyId,
      duration: duration,
      loanPurpose: loanPurpose,
      loanTypeId: loanTypeId,
      password: pinCode,
    );

    resultEither.fold(
      (l) => setErrorMessage(
        "Oops! Your application didn't go through. Please try again.",
      ),
      (r) {
        completed = true;
        _eventBus.fire(LoanApplicationEvent.success);
      },
    );
    setLoading(value: false);
  }
}
