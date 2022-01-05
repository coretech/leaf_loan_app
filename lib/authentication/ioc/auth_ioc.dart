import 'package:get_it/get_it.dart';
import 'package:loan_app/authentication/data/data.dart';
import 'package:loan_app/authentication/domain/domain.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';

class AuthIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator
      ..registerLazySingleton<AuthenticationRepository>(
        () => AuthRemoteRepo(),
      )
      ..registerLazySingleton<AuthHelper>(
        () => AuthHelper(),
      );
  }

  static AuthHelper authHelper() {
    return _locator.get<AuthHelper>();
  }

  static AuthenticationRepository authRepo() {
    return _locator.get<AuthenticationRepository>();
  }
}
