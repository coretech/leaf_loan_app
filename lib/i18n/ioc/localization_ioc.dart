import 'package:get_it/get_it.dart';
import 'package:loan_app/i18n/i18n.dart';

class LocalizationIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator
      ..registerLazySingleton<L10nRepository>(
        () => L10nLocalRepo(),
      )
      ..registerLazySingleton<L10nProvider>(
        () => L10nProvider(),
      );
  }

  static L10nRepository loanApplicationRepo() {
    return _locator.get<L10nRepository>();
  }

  static L10nProvider l10nProvider() {
    return _locator.get<L10nProvider>();
  }
}
