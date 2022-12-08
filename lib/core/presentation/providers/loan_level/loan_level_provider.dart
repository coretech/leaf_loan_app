import 'package:flutter/foundation.dart';
import 'package:loan_app/core/ioc/core_ioc.dart';
import 'package:loan_app/core/presentation/providers/loan_level/loan_level.dart';

class LoanLevelProvider extends ChangeNotifier {
  LoanLevelState state = LoanLevelInitialState();

  final _loanLevelRepo = CoreIoc.loanLevelRepo;

  Future<void> fetchForLoggedInUser() async {
    state = LoanLevelLoadingState();
    notifyListeners();

    final loanLevelEither = await _loanLevelRepo.getLoanLevel();
    loanLevelEither.fold(
      (_) {
        state = LoanLevelFailureState();
      },
      (loanLevel) {
        state = LoanLevelLoadedState(
          loanLevel: loanLevel,
        );
      },
    );
    notifyListeners();
  }
}
