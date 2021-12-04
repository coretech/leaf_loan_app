import 'package:get_it/get_it.dart';
import 'package:loan_app/features/loan_history/data/data.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';

class LoanHistoryIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator.registerLazySingleton<LoanHistoryRepository>(
      () => LoanHistoryRemoteRepo(),
    );
  }

  static LoanHistoryRepository loanHistoryRepo() {
    return _locator.get<LoanHistoryRepository>();
  }
}
