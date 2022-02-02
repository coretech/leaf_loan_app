import 'package:get_it/get_it.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/integrations/integrations.dart';

class IntegrationIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    await HiveLocalStorage.init();
    _locator
      ..registerLazySingleton<Analytics>(
        () => FirebaseAnalyticsIntegration(),
      )
      ..registerLazySingleton<EventBusAbstraction>(
        () => EvenBusIntegration(),
      )
      ..registerLazySingleton<HttpHelper>(
        () => DioHttpHelper(
          /// This could be better architected to avoid the cyclic dependency
          /// we have now between this IOC and AuthHelper
          onResponse: (response) async {
            await AuthIOC.authHelper().processResponse(response);
          },
        ),
      )
      ..registerLazySingleton<LocalStorage>(
        HiveLocalStorage.getInstance,
      )
      ..registerLazySingleton<Logger>(
        () => FirebaseLogger(),
      )
      ..registerLazySingleton<RemoteConfiguration>(
        () => RemoteConfigIntegration(),
      )
      ..registerLazySingleton<ScoringDataCollectionService>(
        () => CredoDataCollectionService(),
      );
  }

  static Future<void> initMock() async {
    await HiveLocalStorage.init();
    _locator
      ..registerLazySingleton<Analytics>(
        () => MockFirebaseAnalytics(),
      )
      ..registerLazySingleton<EventBusAbstraction>(
        () => MockEventBus(),
      )
      ..registerLazySingleton<HttpHelper>(
        () => MockDio(),
      )
      ..registerLazySingleton<LocalStorage>(
        () => MockHive(),
      )
      ..registerLazySingleton<Logger>(
        () => MockLogger(),
      )
      ..registerLazySingleton<RemoteConfiguration>(
        () => MockRemoteConfig(),
      )
      ..registerLazySingleton<ScoringDataCollectionService>(
        () => MockCredo(),
      )
      ..registerLazySingleton<L10n>(
        () => MockL10N(),
      );
  }

  static void registerI18n(L10n localizations) {
    if (_locator.isRegistered<L10n>()) {
      _locator.unregister<L10n>();
    }
    _locator.registerLazySingleton<L10n>(() => localizations);
  }

  static Analytics analytics() {
    return _locator.get<Analytics>();
  }

  static EventBusAbstraction eventBus() {
    return _locator.get<EventBusAbstraction>();
  }

  static HttpHelper httpHelper() {
    return _locator.get<HttpHelper>();
  }

  static LocalStorage localStorage() {
    return _locator.get<LocalStorage>();
  }

  static Logger logger() {
    return _locator.get<Logger>();
  }

  static L10n l10n() {
    return _locator.get<L10n>();
  }

  static RemoteConfiguration remoteConfig() {
    return _locator.get<RemoteConfiguration>();
  }

  static ScoringDataCollectionService scoringDataCollectionService() {
    return _locator.get<ScoringDataCollectionService>();
  }
}
