import 'package:get_it/get_it.dart';
import 'package:loan_app/features/home/presentation/providers/home_provider.dart';

class HomeIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator.registerLazySingleton<HomeProvider>(
      () => HomeProvider(),
    );
  }

  static HomeProvider homeProvider() {
    return _locator.get<HomeProvider>();
  }
}
