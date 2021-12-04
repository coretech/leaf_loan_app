import 'package:loan_app/core/core.dart';

extension I18n on String {
  String tr() {
    return IntegrationIOC.getL10n().translate(this);
  }
}
