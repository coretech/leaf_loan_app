import 'package:flutter/foundation.dart';

import 'package:loan_app/core/domain/value_objects/value_objects.dart';

abstract class DynamicLinking {
  Future<void> init(ValueChanged<DynamicLinkData> onLink);
}
