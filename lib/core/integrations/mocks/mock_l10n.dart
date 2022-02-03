import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:mocktail/mocktail.dart';

class MockL10N extends Mock implements L10n {
  @override
  String translate(String key, {Map<String, String>? values}) {
    var value = key;
    if (values != null) {
      values.forEach((key, _) {
        value = value.replaceAll('{$key}', values[key]!);
      });
    }
    return value;
  }
}
