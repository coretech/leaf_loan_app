import 'package:get_it/get_it.dart';
import 'package:loan_app/features/loan_history/data/data.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';
import 'package:loan_app/features/loan_history/presentation/providers/providers.dart';

class LoanHistoryIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator
      ..registerLazySingleton<LoanHistoryRepository>(
        () => LoanHistoryRemoteRepo(),
      )
      ..registerLazySingleton<LoanHistoryProvider>(
        () => LoanHistoryProvider(),
      );
  }

  static LoanHistoryRepository loanHistoryRepo() {
    return _locator.get<LoanHistoryRepository>();
  }

  static LoanHistoryProvider loanHistoryProvider() {
    return _locator.get<LoanHistoryProvider>();
  }
}
