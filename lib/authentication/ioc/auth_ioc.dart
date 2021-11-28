import 'package:get_it/get_it.dart';
import 'package:loan_app/authentication/data/data.dart';
import 'package:loan_app/authentication/domain/domain.dart';

class AuthIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator.registerLazySingleton<AuthenticationRepository>(
      () => AuthRepoImplementation(),
    );
  }

  static AuthenticationRepository authRepo() {
    return _locator.get<AuthenticationRepository>();
  }
}
