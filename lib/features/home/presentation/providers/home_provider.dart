import 'package:flutter/foundation.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:loan_app/features/loan_history/domain/repositories/loan_history_repository.dart';
import 'package:loan_app/features/loan_history/ioc/ioc.dart';
import 'package:loan_app/features/loan_payment/domain/domain.dart';
import 'package:loan_app/features/loan_payment/ioc/ioc.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    _eventBus.on<LoanApplicationEvent>().listen((event) async {
      await getActiveLoan();
    });

    _eventBus.on<LoanPaymentSuccess>().listen((event) async {
      await getActiveLoan();
    });

    _eventBus.on<NotificationEvent>().listen((event) async {
      await getActiveLoan();
    });
  }

  bool loading = false;
  bool loadingPayments = false;

  String firstName = '';

  String? errorMessage;

  List<Payment> payments = [];
  LoanData? activeLoan;
  bool paymentsLoaded = false;

  final _loanPaymentRepo = LoanPaymentIOC.loanPaymentRepo();
  final _loanHistoryRepo = LoanHistoryIOC.loanHistoryRepo();

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
    activeLoan = null;
    loading = false;
    errorMessage = null;
    firstName = '';
    payments = [];
    paymentsLoaded = false;
    loadingPayments = false;
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
    // TODO(Yabsra): create a local user repo
    if (firstName.isEmpty) {
      firstName =
          (await IntegrationIOC.localStorage().getString(Keys.firstName)) ?? '';
    }
    setLoading(value: true);
    final _loanResult = await _loanHistoryRepo.getActiveLoan();
    await _loanResult.fold(
      (error) {
        if (error == LoanHistoryFailure.error) {
          setErrorMessage(
            value: 'Not sure what went wrong.'
                '\nAre you connected to the internet?',
          );
        }
        setLoading(value: false);
      },
      (loanData) async {
        activeLoan = loanData;
        setLoading(value: false);
        if (loanStatusFromString(activeLoan!.status) != LoanStatus.pending) {
          await getPayments();
        }
      },
    );
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
  }
}
