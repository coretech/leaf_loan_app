import 'package:get_it/get_it.dart';
import 'package:loan_app/features/authentication/data/data.dart';
import 'package:loan_app/features/authentication/domain/domain.dart';

class AuthIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRemoteRepository(),
    );
  }

  static AuthenticationRepository authRepo() {
    return _locator.get<AuthenticationRepository>();
  }
}
