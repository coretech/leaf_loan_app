import 'package:get_it/get_it.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/integrations/integrations.dart';

class IntegrationIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    await HiveLocalStorage.init();
    _locator
      ..registerLazySingleton<LocalStorage>(
        HiveLocalStorage.getInstance,
      )
      ..registerLazySingleton<ScoringDataCollectionService>(
        () => CredoDataCollectionService(),
      )
      ..registerLazySingleton<HttpHelper>(
        () => DioHttpHelper(
          /// This could be better architected to avoid the cyclic dependency
          /// we have now between this IOC and AuthHelper
          onResponse: (response) async {
            await AuthIOC.authHelper().processResponse(response);
          },
        ),
      );
  }

  static LocalStorage localStorage() {
    return _locator.get<LocalStorage>();
  }

  static ScoringDataCollectionService scoringDataCollectionService() {
    return _locator.get<ScoringDataCollectionService>();
  }

  static HttpHelper httpHelper() {
    return _locator.get<HttpHelper>();
  }
}
