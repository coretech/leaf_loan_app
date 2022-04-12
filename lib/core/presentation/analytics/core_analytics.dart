import 'package:loan_app/core/ioc/ioc.dart';

class CoreAnalytics {
  static void logLanguageChanged(
    String languageCode,
    String componentLocation,
  ) {
    IntegrationIOC.analytics.logEvent(
      'language_changed',
      parameters: <String, dynamic>{
        'language_code': languageCode,
        'component_location': componentLocation,
      },
    );
  }
}
