import 'dart:convert';

import 'package:loan_app/core/domain/entities/loan_level.dart';

abstract class LoanLevelMapper {
  static LoanLevel fromJson(String source) => fromMap(json.decode(source));

  static LoanLevel fromMap(Map<String, dynamic> map) {
    return LoanLevel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }
}
