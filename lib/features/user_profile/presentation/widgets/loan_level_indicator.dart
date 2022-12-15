import 'package:flutter/material.dart';
import 'package:loan_app/core/presentation/providers/loan_level/loan_level.dart';
import 'package:loan_app/core/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoanLevelIndicator extends StatefulWidget {
  const LoanLevelIndicator({Key? key}) : super(key: key);

  @override
  State<LoanLevelIndicator> createState() => _LoanLevelIndicatorState();
}

class _LoanLevelIndicatorState extends State<LoanLevelIndicator> {
  final _provider = LoanLevelProvider();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider..fetchForLoggedInUser(),
      builder: (context, _) {
        return Column(
          children: [
            _buildSelector(context),
          ],
        );
      },
    );
  }

  Widget _buildSelector(BuildContext context) {
    return Selector<LoanLevelProvider, LoanLevelState>(
      builder: (context, state, _) {
        if (state is LoanLevelLoadedState) {
          return Column(
            children: [
              Text(
                'Eligible for ${state.loanLevel.name} Loans',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
                endIndent: 120,
                height: 40,
                indent: 120,
              ),
            ],
          );
        }

        if (state is LoanLevelLoadingState) {
          return Column(
            children: const [
              ShimmerBox(
                width: 100,
                height: 20,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
      selector: (context, provider) => provider.state,
    );
  }
}
