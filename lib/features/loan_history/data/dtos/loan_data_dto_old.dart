import 'dart:convert';

import 'package:loan_app/core/data/data.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';

class LoanDataDto2 {
  LoanDataDto2({
    required this.status,
    required this.id,
    required this.customerid,
    required this.loantypeid,
    required this.loanpurpose,
    required this.currencyid,
    required this.duedate,
    required this.requestedamount,
    required this.interestamount,
    required this.totalamount,
    required this.remainingamount,
    required this.duration,
    required this.requestdate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LoanDataDto2.fromMap(Map<String, dynamic> map) {
    return LoanDataDto2(
      status: map['status'],
      id: map['_id'],
      customerid: map['customerid'],
      loantypeid: LoanTypeDto.fromMap(map['loantypeid'] ?? map['loanid']),
      loanpurpose: map['loanpurpose'],
      currencyid: map['currencyid'] != null
          ? CurrencyIdDtoOld.fromMap(map['currencyid'])
          : null,
      duedate: map['duedate'],
      requestedamount: double.parse(map['requestedamount'].toString()),
      interestamount: double.parse(map['interestamount'].toString()),
      totalamount: double.parse(map['totalamount'].toString()),
      remainingamount: double.parse(map['remainingamount'].toString()),
      duration: map['duration'],
      requestdate: map['requestdate'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  factory LoanDataDto2.fromJson(String source) =>
      LoanDataDto2.fromMap(json.decode(source));

  LoanData toEntity() {
    return LoanData(
      status: status,
      id: id,
      customerId: customerid,
      loanTypeId: loantypeid.toEntity(),
      loanPurpose: loanpurpose,
      currencyId: currencyid?.toEntity(),
      dueDate: duedate,
      requestedAmount: requestedamount,
      interestAmount: interestamount,
      totalAmount: totalamount,
      remainingAmount: remainingamount,
      duration: duration,
      requestDate: requestdate,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  final String status;
  final String id;
  final String customerid;
  final LoanTypeDto loantypeid;
  final String loanpurpose;
  final CurrencyIdDtoOld? currencyid;
  final String duedate;
  final double requestedamount;
  final double interestamount;
  final double totalamount;
  final double remainingamount;
  final int duration;
  final String requestdate;
  final String createdAt;
  final String updatedAt;

  LoanDataDto2 copyWith({
    String? status,
    String? id,
    String? customerid,
    LoanTypeDto? loantypeid,
    String? loanpurpose,
    CurrencyIdDtoOld? currencyid,
    String? duedate,
    double? requestedamount,
    double? interestamount,
    double? totalamount,
    double? remainingamount,
    int? duration,
    String? requestdate,
    String? createdAt,
    String? updatedAt,
  }) {
    return LoanDataDto2(
      status: status ?? this.status,
      id: id ?? this.id,
      customerid: customerid ?? this.customerid,
      loantypeid: loantypeid ?? this.loantypeid,
      loanpurpose: loanpurpose ?? this.loanpurpose,
      currencyid: currencyid ?? this.currencyid,
      duedate: duedate ?? this.duedate,
      requestedamount: requestedamount ?? this.requestedamount,
      interestamount: interestamount ?? this.interestamount,
      totalamount: totalamount ?? this.totalamount,
      remainingamount: remainingamount ?? this.remainingamount,
      duration: duration ?? this.duration,
      requestdate: requestdate ?? this.requestdate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      '_id': id,
      'customerid': customerid,
      'loantypeid': loantypeid.toMap(),
      'loanpurpose': loanpurpose,
      'currencyid': currencyid?.toMap(),
      'duedate': duedate,
      'requestedamount': requestedamount,
      'interestamount': interestamount,
      'totalamount': totalamount,
      'remainingamount': remainingamount,
      'duration': duration,
      'requestdate': requestdate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'LoanDataDto2(status: $status, _id: $id, customerid: $customerid, '
        'loantypeid: $loantypeid, loanpurpose: $loanpurpose, currencyid: '
        '$currencyid, duedate: $duedate, requestedamount: $requestedamount, '
        'interestamount: $interestamount, totalamount: $totalamount, '
        'remainingamount: $remainingamount, duration: $duration, requestdate: '
        '$requestdate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoanDataDto2 &&
        other.status == status &&
        other.id == id &&
        other.customerid == customerid &&
        other.loantypeid == loantypeid &&
        other.loanpurpose == loanpurpose &&
        other.currencyid == currencyid &&
        other.duedate == duedate &&
        other.requestedamount == requestedamount &&
        other.interestamount == interestamount &&
        other.totalamount == totalamount &&
        other.remainingamount == remainingamount &&
        other.duration == duration &&
        other.requestdate == requestdate &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        id.hashCode ^
        customerid.hashCode ^
        loantypeid.hashCode ^
        loanpurpose.hashCode ^
        currencyid.hashCode ^
        duedate.hashCode ^
        requestedamount.hashCode ^
        interestamount.hashCode ^
        totalamount.hashCode ^
        remainingamount.hashCode ^
        duration.hashCode ^
        requestdate.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
