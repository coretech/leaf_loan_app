import 'package:get_it/get_it.dart';
import 'package:loan_app/features/user_profile/data/data.dart';
import 'package:loan_app/features/user_profile/domain/domain.dart';

class UserIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator.registerLazySingleton<UserRepository>(
      () => UserRemoteRepository(),
    );
  }

  static UserRepository userRepo() {
    return _locator.get<UserRepository>();
  }
}
