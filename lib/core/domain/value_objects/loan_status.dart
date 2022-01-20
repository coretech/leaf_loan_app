enum LoanStatus { approved, closed, pending, rejected, due }

LoanStatus loanStatusFromString(String status) {
  switch (status.toLowerCase()) {
    case 'approved':
      return LoanStatus.approved;
    case 'pending':
      return LoanStatus.pending;
    case 'rejected':
      return LoanStatus.rejected;
    case 'due':
      return LoanStatus.due;
    case 'closed':
      return LoanStatus.closed;
    default:
      return LoanStatus.pending;
  }
}
