import 'package:get_it/get_it.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';

class LoanApplicationIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator
      ..registerLazySingleton<LoanTypeRepository>(
        () => LoanTypeRemoteRepo(),
      )
      ..registerLazySingleton<LoanApplicationRepository>(
        () => LoanApplicationRemoteRepo(),
      )
      ..registerLazySingleton<LoanTypesProvider>(
        () => LoanTypesProvider(),
      )
      ..registerLazySingleton<PermissionsProvider>(
        () => PermissionsProvider(),
      );
  }

  static LoanTypeRepository get loanTypeRepo {
    return _locator.get<LoanTypeRepository>();
  }

  static LoanApplicationRepository loanApplicationRepo() {
    return _locator.get<LoanApplicationRepository>();
  }

  static LoanTypesProvider get loanTypesProvider {
    return _locator.get<LoanTypesProvider>();
  }

  static PermissionsProvider get permissionsProvider {
    return _locator.get<PermissionsProvider>();
  }
}
