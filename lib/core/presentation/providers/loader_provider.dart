import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class LoaderProvider<T> extends ChangeNotifier {
  LoaderProvider({
    required this.loader,
  });
  final Future<Either<dynamic, T>> Function() loader;

  bool loading = false;

  String? errorMessage;

  T? data;

  bool get isDone => loading == false && errorMessage == null && data != null;

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

  Future<void> load() async {
    clear();
    setLoading(value: true);

    final result = await loader();
    result.fold(
      (error) {
        setErrorMessage(value: error.toString());
      },
      (data) {
        this.data = data;
      },
    );

    setLoading(value: false);
  }
}
