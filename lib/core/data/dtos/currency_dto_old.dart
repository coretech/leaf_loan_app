import 'dart:convert';

import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/domain/entities/entities.dart';

class CurrencyDtoOld {
  CurrencyDtoOld({
    this.currencyid,
    required this.minloanamount,
    required this.maxloanamount,
  });

  factory CurrencyDtoOld.fromMap(Map<String, dynamic> map) {
    return CurrencyDtoOld(
      // ignore: avoid_dynamic_calls
      currencyid: (map['currencyid'] is String || map['currencyid'] == null)
          ? null
          : CurrencyIdDtoOld.fromMap(map['currencyid']),
      minloanamount: map['minloanamount'],
      maxloanamount: map['maxloanamount'],
    );
  }

  factory CurrencyDtoOld.fromJson(String source) =>
      CurrencyDtoOld.fromMap(json.decode(source));

  final CurrencyIdDtoOld? currencyid;
  final int minloanamount;
  final int maxloanamount;

  Currency toEntity() {
    return Currency(
      currencyId: currencyid?.toEntity(),
      minLoanAmount: minloanamount,
      maxLoanAmount: maxloanamount,
    );
  }

  CurrencyDtoOld copyWith({
    CurrencyIdDtoOld? currencyid,
    int? minloanamount,
    int? maxloanamount,
  }) {
    return CurrencyDtoOld(
      currencyid: currencyid ?? this.currencyid,
      minloanamount: minloanamount ?? this.minloanamount,
      maxloanamount: maxloanamount ?? this.maxloanamount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currencyid': currencyid?.toMap(),
      'minloanamount': minloanamount,
      'maxloanamount': maxloanamount,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'CurrencyDTO(currencyid: $currencyid, minloanamount: $minloanamount, '
      'maxloanamount: $maxloanamount)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyDtoOld &&
        other.currencyid == currencyid &&
        other.minloanamount == minloanamount &&
        other.maxloanamount == maxloanamount;
  }

  @override
  int get hashCode =>
      currencyid.hashCode ^ minloanamount.hashCode ^ maxloanamount.hashCode;
}
