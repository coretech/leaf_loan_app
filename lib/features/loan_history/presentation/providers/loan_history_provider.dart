import 'package:flutter/foundation.dart';
import 'package:loan_app/core/events/events.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/features/features.dart';

class LoanHistoryProvider extends ChangeNotifier {
  LoanHistoryProvider() {
    _eventBus.on<LoanApplicationEvent>().listen((event) async {
      if (event == LoanApplicationEvent.success) {
        await getLoans();
      }
    });

    _eventBus.on<NotificationEvent>().listen((event) async {
      await getLoans();
    });
  }

  final _loanHistoryRepository = LoanHistoryIOC.loanHistoryRepo();

  final _eventBus = IntegrationIOC.eventBus;

  List<LoanData> _loanHistory = [];

  List<LoanData> get loans => _loanHistory;

  bool loading = false;

  String? errorMessage;

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
    clear();
    setLoading(value: true);
    final resultEither = await _loanHistoryRepository.getLoans();
    resultEither.fold(
      (l) {
        setErrorMessage(
          value: "We couldn't get your loan history. Please try again.",
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
