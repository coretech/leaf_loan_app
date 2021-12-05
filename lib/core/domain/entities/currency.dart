
import 'package:loan_app/core/domain/entities/currency_id.dart';

class Currency {
  Currency({
    required this.currencyId,
    required this.minLoanAmount,
    required this.maxLoanAmount,
  });
  final CurrencyId? currencyId;
  final int minLoanAmount;
  final int maxLoanAmount;

  Currency copyWith({
    CurrencyId? currencyId,
    int? minLoanAmount,
    int? maxLoanAmount,
  }) {
    return Currency(
      currencyId: currencyId ?? this.currencyId,
      minLoanAmount: minLoanAmount ?? this.minLoanAmount,
      maxLoanAmount: maxLoanAmount ?? this.maxLoanAmount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Currency &&
        other.currencyId == currencyId &&
        other.minLoanAmount == minLoanAmount &&
        other.maxLoanAmount == maxLoanAmount;
  }

  @override
  int get hashCode =>
      currencyId.hashCode ^ minLoanAmount.hashCode ^ maxLoanAmount.hashCode;
}
