import 'package:get_it/get_it.dart';
import 'package:loan_app/core/core.dart';

class IntegrationInjector {
  static final _locator = GetIt.instance;

  static init() async {
    
    await HiveLocalStorage.init();
    _locator.registerLazySingleton<LocalStorage>(
      () => HiveLocalStorage.getInstance(),
    );
  }

  static LocalStorage localStorage() {
    return _locator.get<LocalStorage>();
  }
}
