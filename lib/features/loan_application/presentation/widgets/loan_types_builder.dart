import 'package:flutter/material.dart';

import 'package:loan_app/core/domain/domain.dart';
import 'package:loan_app/features/features.dart';
import 'package:provider/provider.dart';

class LoanTypesBuilder extends StatelessWidget {
  const LoanTypesBuilder({
    Key? key,
    required this.onSuccess,
    required this.onError,
  }) : super(key: key);

  final Function(BuildContext, List<LoanType>) onSuccess;
  final Function(BuildContext, String) onError;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: LoanApplicationIOC.loanTypesProvider,
      builder: (context, _) {
        return Selector<LoanTypesProvider, LoanTypesState>(
          selector: (context, repo) => repo.state,
          builder: (context, state, _) {
            if (state is LoanTypesLoaded) {
              return onSuccess(context, state.loanTypes);
            }

            if (state is LoanTypesError) {
              return onError(context, state.message);
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                Text('Fetching loan types...'),
              ],
            );
          },
        );
      },
    );
  }
}
