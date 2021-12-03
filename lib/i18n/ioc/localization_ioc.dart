import 'package:get_it/get_it.dart';
import 'package:loan_app/i18n/data/data.dart';
import 'package:loan_app/i18n/domain/domain.dart';

class LocalizationIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator.registerLazySingleton<LocalizationRepository>(
      () => LocalizationLocalRepo(),
    );
  }

  static LocalizationRepository loanApplicationRepo() {
    return _locator.get<LocalizationRepository>();
  }
}
