library token_util_test;

import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/utils/token_util.dart';

void main() {
  test(
    'Given a token x, '
    'When TokenUtil.generateBearer(x) is called, '
    'Then a MapEntry will be created which should look '
    "like 'Authorization': 'Bearer x'",
    () {
      const token = 'x';
      final result = TokenUtil.generateBearer(token);
      expect(result, isA<MapEntry>());
      expect(result.key, 'Authorization');
      expect(result.value, 'Bearer $token');
    },
  );
}
