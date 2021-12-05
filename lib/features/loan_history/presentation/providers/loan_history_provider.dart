import 'package:flutter/foundation.dart';
import 'package:loan_app/features/features.dart';

class LoanHistoryProvider extends ChangeNotifier {
  List<LoanData> _loanHistory = [];

  List<LoanData> get loans => _loanHistory;

  bool loading = false;

  String? errorMessage;

  final LoanHistoryRepository loanTypeRepository =
      LoanHistoryIOC.loanHistoryRepo();

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

  Future<void> getLoans() async {
    setLoading(value: true);
    final resultEither = await loanTypeRepository.getLoans();
    resultEither.fold(
      (l) {
        setErrorMessage(
          value: 'Fetching loan history failed',
        );
      },
      (r) {
        _loanHistory = r;
      },
    );
    setLoading(value: false);
    notifyListeners();
  }
}
