import 'package:get_it/get_it.dart';
import 'package:loan_app/features/loan_payment/data/repositories/repositories.dart';
import 'package:loan_app/features/loan_payment/domain/domain.dart';

class LoanPaymentIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator.registerLazySingleton<LoanPaymentRepo>(
      () => LoanPaymentRemoteRepo(),
    );
  }

  static LoanPaymentRepo loanPaymentRepo() {
    return _locator.get<LoanPaymentRepo>();
  }
}
