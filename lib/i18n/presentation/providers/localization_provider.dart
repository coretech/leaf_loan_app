import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:loan_app/i18n/domain/domain.dart';
import 'package:loan_app/i18n/ioc/ioc.dart';

class LocalizationProvider extends ChangeNotifier {
  LocalizationProvider() {
    _init();
  }
  late Locale _locale;

  final LocalizationRepository _localizationRepository =
      LocalizationIOC.loanApplicationRepo();

  Locale get locale => _locale;

  Future<void> _init() async {
    final language = await _localizationRepository.getLanguage();
    if (language != null) {
      _locale = Locale.fromSubtags(languageCode: language);
    } else {
      _locale = WidgetsBinding.instance!.window.locale;
    }

    notifyListeners();
  }

  void changeLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
