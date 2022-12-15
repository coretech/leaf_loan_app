import 'package:flutter/foundation.dart';
import 'package:loan_app/features/loan_application/loan_application.dart';

class LoanTypesProvider extends ChangeNotifier {
  LoanTypesState state = LoanTypesInitial();

  final LoanTypeRepository loanTypeRepository = LoanApplicationIOC.loanTypeRepo;

  Future<void> fetch() async {
    state = LoanTypesLoading();
    notifyListeners();
    final loanTypesEither = await loanTypeRepository.getLoanTypes();
    loanTypesEither.fold(
      (l) {
        state =
            LoanTypesError('Something went wrong while fetching loan types');
      },
      (loanTypes) {
        loanTypes.sort((a, b) => a.loanLevel.name.compareTo(b.loanLevel.name));
        state = LoanTypesLoaded(loanTypes);
      },
    );
    notifyListeners();
  }
}
