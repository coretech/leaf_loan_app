import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:provider/provider.dart';

class MaxLoanAmountText extends StatefulWidget {
  const MaxLoanAmountText({Key? key}) : super(key: key);

  @override
  State<MaxLoanAmountText> createState() => _MaxLoanAmountTextState();
}

class _MaxLoanAmountTextState extends State<MaxLoanAmountText> {
  MapEntry<String, num>? currentAmount;
  Map<String, num> maxAmounts = {};
  late Timer timer;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      LoanApplicationIOC.loanTypesProvider.fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 3),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
      child: ChangeNotifierProvider.value(
        value: LoanApplicationIOC.loanTypesProvider,
        builder: (context, _) {
          return Selector<LoanTypesProvider, LoanTypesState>(
            selector: (_, provider) => provider.state,
            builder: (context, state, _) {
              if (state is LoanTypesLoaded && currentAmount != null) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 2),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: _buildText(context),
                );
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  void _init() {
    LoanApplicationIOC.loanTypesProvider.addListener(() {
      final loanTypeProvider = LoanApplicationIOC.loanTypesProvider;
      final state = loanTypeProvider.state;
      if (state is LoanTypesLoaded) {
        for (final loanType in state.loanTypes) {
          for (final currency in loanType.currencies) {
            if ((maxAmounts[currency.fiatCode] ?? 0) < currency.maxLoanAmount) {
              maxAmounts[currency.fiatCode] = currency.maxLoanAmount;
            }
          }
        }
      }
    });

    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (mounted && maxAmounts.isNotEmpty) {
          setState(() {
            currentAmount = maxAmounts.entries.elementAt(currentIndex);
            currentIndex++;
            currentIndex %= maxAmounts.length;
          });
        }
      },
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      '${'You can take loans up to'.tr()} '
      '${currentAmount!.key} '
      '${Formatter.formatMoney(
        currentAmount!.value.toDouble(),
      )}',
      key: UniqueKey(),
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 12,
      ),
    );
  }
}
