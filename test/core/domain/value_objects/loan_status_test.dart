import 'package:flutter_test/flutter_test.dart';
import 'package:loan_app/core/domain/value_objects/loan_status.dart';

void main() {
  test(
    "Given a loan status text 'approved', "
    'When loanStatusFromString is called, '
    'Then LoanStatus.approved must be returned',
    () {
      final loanStatus = loanStatusFromString('approved');
      expect(loanStatus, LoanStatus.approved);
    },
  );

  test(
    "Given a loan status text 'pending', "
    'When loanStatusFromString is called, '
    'Then LoanStatus.pending must be returned',
    () {
      final loanStatus = loanStatusFromString('pending');
      expect(loanStatus, LoanStatus.pending);
    },
  );

  test(
    "Given a loan status text 'rejected', "
    'When loanStatusFromString is called, '
    'Then LoanStatus.rejected must be returned',
    () {
      final loanStatus = loanStatusFromString('rejected');
      expect(loanStatus, LoanStatus.rejected);
    },
  );

  test(
    "Given a loan status text 'due', "
    'When loanStatusFromString is called, '
    'Then LoanStatus.due must be returned',
    () {
      final loanStatus = loanStatusFromString('due');
      expect(loanStatus, LoanStatus.due);
    },
  );

  test(
    "Given a loan status text 'closed', "
    'When loanStatusFromString is called, '
    'Then LoanStatus.closed must be returned',
    () {
      final loanStatus = loanStatusFromString('closed');
      expect(loanStatus, LoanStatus.closed);
    },
  );
}
