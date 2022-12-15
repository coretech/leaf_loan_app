import 'package:get_it/get_it.dart';
import 'package:loan_app/core/data/repositories/repositories.dart';
import 'package:loan_app/core/domain/repositories/repositories.dart';
import 'package:loan_app/core/presentation/providers/loan_level/loan_level.dart';

class CoreIoc {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator
      ..registerLazySingleton<LoanLevelProvider>(
        () => LoanLevelProvider(),
      )
      ..registerLazySingleton<LoanLevelRepository>(
        () => LoanLevelRemoteRepository(),
      );
  }

  static LoanLevelProvider get loanLevelProvider {
    return _locator.get<LoanLevelProvider>();
  }

  static LoanLevelRepository get loanLevelRepo {
    return _locator.get<LoanLevelRepository>();
  }
}
