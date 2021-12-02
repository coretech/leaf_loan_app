import 'package:get_it/get_it.dart';
import 'package:loan_app/features/loan_application/data/data.dart';
import 'package:loan_app/features/loan_application/domain/domain.dart';

class LoanApplicationIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator
      ..registerLazySingleton<LoanTypeRepository>(
        () => LoanTypeRemoteRepo(),
      )
      ..registerLazySingleton<LoanApplicationRepository>(
        () => LoanApplicationRemoteRepo(),
      );
  }

  static LoanTypeRepository loanTypeRepo() {
    return _locator.get<LoanTypeRepository>();
  }

  static LoanApplicationRepository loanApplicationRepo() {
    return _locator.get<LoanApplicationRepository>();
  }
}
