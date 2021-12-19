import 'package:loan_app/core/ioc/ioc.dart';

class SettingsAnalytics {
  static void logLanguageChanged(String languageCode) {
    IntegrationIOC.analytics().logEvent(
      'language_changed',
      parameters: <String, dynamic>{
        'language_code': languageCode,
      },
    );
  }
}
