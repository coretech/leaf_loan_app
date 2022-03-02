import 'package:get_it/get_it.dart';
import 'package:loan_app/features/articles/data/repositories/repositories.dart';
import 'package:loan_app/features/articles/domain/repositories/repositories.dart';
import 'package:loan_app/features/articles/presentation/providers/providers.dart';

class ArticlesIOC {
  static final _locator = GetIt.instance;

  static Future<void> init() async {
    _locator
      ..registerLazySingleton<ArticlesRepository>(
        () => ArticlesRemoteRepo(),
      )
      ..registerLazySingleton<ArticlesProvider>(
        () => ArticlesProvider(),
      );
  }

  static ArticlesRepository get articlesRepo {
    return _locator.get<ArticlesRepository>();
  }

  static ArticlesProvider get articlesProvider {
    return _locator.get<ArticlesProvider>()..getArticles();
  }
}
