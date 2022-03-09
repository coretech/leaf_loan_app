import 'package:get_it/get_it.dart';
import 'package:loan_app/features/user_profile/data/data.dart';
import 'package:loan_app/features/user_profile/data/repositories/stats_remote_repository.dart';
import 'package:loan_app/features/user_profile/data/repositories/wallet_remote_repository.dart';
import 'package:loan_app/features/user_profile/domain/domain.dart';

class UserIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator
      ..registerLazySingleton<UserRepository>(
        () => UserRemoteRepository(),
      )
      ..registerLazySingleton<WalletRepository>(
        () => WalletRemoteRepository(),
      )
      ..registerLazySingleton<StatsRepository>(
        () => StatsRemoteRepository(),
      );
  }

  static UserRepository userRepo() {
    return _locator.get<UserRepository>();
  }

  static WalletRepository walletRepo() {
    return _locator.get<WalletRepository>();
  }

  static StatsRepository get statsRepo {
    return _locator.get<StatsRepository>();
  }
}
