import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/i18n/domain/domain.dart';

class LocalizationLocalRepo extends LocalizationRepository {
  final LocalStorage _localStorage = IntegrationIOC.localStorage();
  @override
  Future<String?> getLanguage() {
    return _localStorage.getString(Keys.language);
  }

  @override
  Future<void> setLanguage(String language) {
    return _localStorage.setString(Keys.language, language);
  }
}
