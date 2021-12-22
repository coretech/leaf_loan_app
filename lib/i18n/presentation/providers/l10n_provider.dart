import 'package:flutter/widgets.dart';
import 'package:loan_app/i18n/i18n.dart';

class L10nProvider extends ChangeNotifier {
  L10nProvider() {
    _init();
  }

  Locale? _locale;

  final L10nRepository _l10nRepository = LocalizationIOC.loanApplicationRepo();

  Locale get locale => _locale ?? const Locale('en');

  Future<void> _init() async {
    final language = await _l10nRepository.getLanguage();
    if (language != null) {
      _locale = Locale.fromSubtags(languageCode: language);
    } else {
      _locale = WidgetsBinding.instance!.window.locale;
    }

    notifyListeners();
  }

  Future<void> changeLocale(Locale locale) async {
    _locale = locale;
    await _l10nRepository.setLanguage(locale.languageCode);
    await AppLocalizations.delegate.load(locale);
    notifyListeners();
  }
}
