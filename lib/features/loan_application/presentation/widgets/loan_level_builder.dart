import 'package:flutter/material.dart';
import 'package:loan_app/core/domain/domain.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/presentation/providers/loan_level/loan_level.dart';
import 'package:provider/provider.dart';

class LoanLevelBuilder extends StatelessWidget {
  const LoanLevelBuilder({
    Key? key,
    required this.loanLevelProvider,
    required this.onError,
    required this.onSuccess,
  }) : super(key: key);

  final LoanLevelProvider loanLevelProvider;
  final Function(BuildContext, String) onError;
  final Function(BuildContext, LoanLevel) onSuccess;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: CoreIoc.loanLevelProvider,
      builder: (context, _) {
        return Selector<LoanLevelProvider, LoanLevelState>(
          selector: (context, repo) => repo.state,
          builder: (context, state, _) {
            if (state is LoanLevelLoadedState) {
              return onSuccess(context, state.loanLevel);
            }

            if (state is LoanLevelFailureState) {
              return onError(context, state.message);
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Spacer(),
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                Text('Checking allowed loan levels...'),
                Spacer(),
              ],
            );
          },
        );
      },
    );
  }
}
