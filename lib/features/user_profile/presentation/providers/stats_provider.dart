import 'package:flutter/foundation.dart';
import 'package:loan_app/features/user_profile/domain/domain.dart';
import 'package:loan_app/features/user_profile/ioc/ioc.dart';

class StatsProvider extends ChangeNotifier {
  final _statsRepository = UserIOC.statsRepo;

  List<Stat> _stats = [];

  List<Stat> get stats => _stats;

  bool loading = false;

  String? errorMessage;

  void setLoading({required bool value}) {
    loading = value;
    notifyListeners();
  }

  void setErrorMessage({required String? value}) {
    errorMessage = value;
    notifyListeners();
  }

  void clearErrorMessage() {
    errorMessage = null;
    notifyListeners();
  }

  void clear() {
    loading = false;
    errorMessage = null;
    notifyListeners();
  }

  Future<void> getStats() async {
    clear();
    setLoading(value: true);
    final resultEither = await _statsRepository.getStats();
    resultEither.fold(
      (l) {
        setErrorMessage(
          value: "We couldn't get your loan stats. Please try again.",
        );
      },
      (r) {
        _stats = r;
      },
    );
    setLoading(value: false);
    notifyListeners();
  }
}
