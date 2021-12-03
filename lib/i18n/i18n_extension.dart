import 'package:loan_app/core/core.dart';

extension I18n on String {
  
  static final _localization = IntegrationIOC.localization();
  String tr() {
    return _localization.translate(this);
  }
}
