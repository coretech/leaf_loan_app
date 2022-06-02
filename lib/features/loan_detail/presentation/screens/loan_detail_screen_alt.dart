import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_application/presentation/screens/loan_application_screen.dart';
import 'package:loan_app/features/loan_detail/presentation/presentation.dart';
import 'package:loan_app/features/loan_detail/presentation/widgets/alt/gradient_card.dart';
import 'package:loan_app/features/loan_history/domain/entities/entities.dart';
import 'package:loan_app/features/loan_payment/presentation/presentation.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class LoanDetailScreenAlt extends StatefulWidget {
  const LoanDetailScreenAlt({
    Key? key,
    required this.loanDetailArgs,
  }) : super(key: key);
  static const String routeName = '/loan-detail-screen-alt';
  final LoanDetailScreenAltArgs loanDetailArgs;

  @override
  State<LoanDetailScreenAlt> createState() => _LoanDetailScreenAltState();
}

class _LoanDetailScreenAltState extends State<LoanDetailScreenAlt> {
  // LoanData get loan => _loan;

  // late LoanData _loan = widget.loanDetailArgs.loan;
  late LoanCancellationProvider _loanCancellationProvider;
  late LoanDetailProvider _loanDetailProvider;

  @override
  void initState() {
    _loanDetailProvider = LoanDetailProvider()
      ..setLoan(widget.loanDetailArgs.loan);
    _loanCancellationProvider = LoanCancellationProvider()
      ..addListener(() {
        if (_loanCancellationProvider.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _loanCancellationProvider.errorMessage!,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else if (!_loanCancellationProvider.loading &&
            _loanCancellationProvider.cancelled) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Loan application cancelled!'.tr(),
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ),
          );
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            Navigator.of(context).pop();
          });
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _loanDetailProvider,
      child: Consumer<LoanDetailProvider>(
        builder: (context, loanDetailProvider, __) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              title: Text(
                '${loanDetailProvider.loan!.loanType} ${'Details'.tr()}',
              ),
            ),
            body: _buildBody(context, loanDetailProvider),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    LoanDetailProvider loanDetailProvider,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildLoanStatusText(context, loanDetailProvider),
            if (_loanStatus == LoanStatus.approved)
              _buildPaymentCard(context, loanDetailProvider),
            _buildLoanInfoCard(context, loanDetailProvider),
            if (_loanStatus == LoanStatus.approved ||
                _loanStatus == LoanStatus.closed)
              _buildLoanPaymentsCard(context, loanDetailProvider),
            if (_loanStatus == LoanStatus.rejected)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  child: Text(
                    'Apply Again'.tr(),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoanApplicationScreen.routeName);
                  },
                ),
              ),
            if (_loanStatus == LoanStatus.pending)
              ChangeNotifierProvider<LoanCancellationProvider>.value(
                value: _loanCancellationProvider,
                builder: (context, _) {
                  return Builder(
                    builder: (context) {
                      return Consumer<LoanCancellationProvider>(
                        builder: (context, cancellationProvider, _) => Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextButton.icon(
                            icon: cancellationProvider.loading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  )
                                : const Icon(
                                    Icons.close,
                                  ),
                            label: Text('Cancel Application'.tr()),
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.error,
                              ),
                            ),
                            onPressed: () async {
                              final password =
                                  await showPinConfirmationSheet(context);
                              if (password != null) {
                                await cancellationProvider
                                    .cancelLoanApplication(
                                  _loanDetailProvider.loan!.id,
                                  password,
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              )
          ],
        ),
      ),
    );
  }

  Widget _buildLoanStatusText(
    BuildContext context,
    LoanDetailProvider loanDetailProvider,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: _getColor(context),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Colors.white.withOpacity(0.25),
              Colors.black.withOpacity(0.25),
              _getColor(context),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            loanDetailProvider.loan!.status,
            style: TextStyle(
              color: _getStatusColor(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentCard(
    BuildContext context,
    LoanDetailProvider loanDetailProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GradientCard(
        color: _getPayBackgroundColor(context),
        children: [
          Text(
            'Remaining Amount'.tr(),
            style: TextStyle(
              color: _getTextColor(context),
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${loanDetailProvider.loan!.currency.fiatCode} ',
                  style: TextStyle(
                    color: _getTextColor(context),
                  ),
                ),
                TextSpan(
                  text: Formatter.formatMoney(
                    loanDetailProvider.loan!.remainingAmount,
                  ),
                  style: TextStyle(
                    color: _getTextColor(context),
                    fontSize: 31,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'You have'.tr(),
                  style: TextStyle(
                    color: _getTextColor(context),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(
                  text: ' ${_getRemainingDays()} ',
                  style: TextStyle(
                    color: _getTextColor(context),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'days to finish payment'.tr(),
                  style: TextStyle(
                    color: _getTextColor(context),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            child: Text('Pay Now'.tr()),
            onPressed: () {
              Navigator.of(context).pushNamed(
                LoanPaymentScreen.routeName,
                arguments: LoanPaymentScreenArguments(
                  loan: loanDetailProvider.loan!,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoanInfoCard(
    BuildContext context,
    LoanDetailProvider loanDetailProvider,
  ) {
    final loan = loanDetailProvider.loan!;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GradientCard(
        color: Colors.grey[600]!,
        children: [
          Text(
            'Loan Info'.tr(),
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: _getTextColor(context),
                ),
          ),
          _buildDivider(context),
          _buildLoanInfoRow(
            context,
            'Loan Type'.tr(),
            loan.loanType,
          ),
          _buildLoanInfoRow(
            context,
            'Requested Amount'.tr(),
            '${Formatter.formatMoney(loan.requestedAmount)} '
            '${loan.currency.fiatCode}',
          ),
          _buildLoanInfoRow(
            context,
            'Interest Amount'.tr(),
            '${Formatter.formatMoney(loan.interestAmount)} '
            '${loan.currency.fiatCode}',
          ),
          _buildLoanInfoRow(
            context,
            'Total Amount'.tr(),
            '${Formatter.formatMoney(loan.totalAmount)} '
            '${loan.currency.fiatCode}',
          ),
          _buildLoanInfoRow(
            context,
            'Applied On'.tr(),
            Formatter.formatDate(DateTime.parse(loan.requestDate)),
          ),
          _buildLoanInfoRow(
            context,
            '',
            Formatter.formatTime(DateTime.parse(loan.requestDate)),
          ),
          _buildLoanInfoRow(
            context,
            'Duration'.tr(),
            '${loan.duration} ${'days'.tr()}',
          ),
          _buildLoanInfoRow(
            context,
            'Due Date'.tr(),
            Formatter.formatDate(DateTime.parse(loan.dueDate)),
          ),
          _buildLoanInfoRow(
            context,
            'Loan Purpose'.tr(),
            loan.loanPurpose,
          ),
        ],
      ),
    );
  }

  Widget _buildLoanInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: _getTextColor(context),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: _getTextColor(context),
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanPaymentsCard(
    BuildContext context,
    LoanDetailProvider loanDetailProvider,
  ) {
    final loan = loanDetailProvider.loan!;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: GradientCard(
        color: _getBackgroundColor(context),
        children: [
          Text(
            'Payment Info'.tr(),
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: _getTextColor(context),
                ),
          ),
          _buildDivider(context),
          _buildLoanInfoRow(
            context,
            'Total'.tr(),
            '${Formatter.formatMoney(loan.totalAmount)} '
            '${loan.currency.fiatCode}',
          ),
          _buildLoanInfoRow(
            context,
            'Paid Amount'.tr(),
            '${Formatter.formatMoney(loan.totalAmount - loan.remainingAmount)} '
            '${loan.currency.fiatCode}',
          ),
          _buildLoanInfoRow(
            context,
            'Remaining Amount'.tr(),
            '${Formatter.formatMoney(loan.remainingAmount)} '
            '${loan.currency.fiatCode}',
          ),
          _buildTransactionsButton(context, loanDetailProvider),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Divider(
        color: Theme.of(context).colorScheme.secondary,
        endIndent: 30,
        indent: 30,
      ),
    );
  }

  Widget _buildTransactionsButton(
    BuildContext context,
    LoanDetailProvider loanDetailProvider,
  ) {
    final loan = loanDetailProvider.loan!;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ElevatedButton(
        child: Text(
          'View Transactions'.tr(),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(
            LoanTransactionsScreen.routeName,
            arguments: loan,
          );
        },
      ),
    );
  }

  LoanStatus get _loanStatus => loanStatusFromString(
        _loanDetailProvider.loan!.status,
      );

  Color _getTextColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      return Theme.of(context).colorScheme.onSurface;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }

  int _getRemainingDays() {
    final days = DateTime.parse(_loanDetailProvider.loan!.dueDate)
        .difference(DateTime.now())
        .inDays;
    return days.isNegative ? 0 : days;
  }

  Color _getColor(BuildContext context) {
    if (loanStatusFromString(_loanDetailProvider.loan!.status) ==
        LoanStatus.rejected) {
      return Theme.of(context).errorColor;
    } else if (loanStatusFromString(_loanDetailProvider.loan!.status) ==
        LoanStatus.approved) {
      return Theme.of(context).colorScheme.primary;
    }
    return Theme.of(context).disabledColor;
  }

  Color _getStatusColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      return Theme.of(context).colorScheme.onSurface;
    } else {
      return Theme.of(context).colorScheme.onPrimary;
    }
  }

  Color _getPayBackgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  Color _getBackgroundColor(BuildContext context) {
    return Theme.of(context).disabledColor;
  }
}

class LoanDetailScreenAltArgs {
  LoanDetailScreenAltArgs({
    required this.loan,
    required this.hasActiveLoan,
  });

  final LoanData loan;
  final bool hasActiveLoan;
}
