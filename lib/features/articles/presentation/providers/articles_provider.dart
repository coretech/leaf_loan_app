import 'package:flutter/foundation.dart';
import 'package:loan_app/core/domain/entities/entities.dart';
import 'package:loan_app/features/features.dart';

class ArticlesProvider extends ChangeNotifier {
  final _articlesRepository = ArticlesIOC.articlesRepo;

  List<Article> _articles = [];

  List<Article> get articles => _articles;

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

  Future<void> getArticles() async {
    clear();
    setLoading(value: true);
    final resultEither = await _articlesRepository.getArticles();
    resultEither.fold(
      (l) {
        setErrorMessage(
          value: "We couldn't get any articles. Please try again.",
        );
      },
      (r) {
        _articles = r;
      },
    );
    setLoading(value: false);
    notifyListeners();
  }
}
