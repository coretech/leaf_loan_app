import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/abstractions/http_helper.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/domain/entities/article.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/articles/data/dtos/dtos.dart';
import 'package:loan_app/features/articles/domain/domain.dart';

class ArticlesRemoteRepo implements ArticlesRepository {
  final AuthHelper _authHelper = AuthIOC.authHelper();
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();
  @override
  Future<Either<ArticlesFailure, List<Article>>> getArticles() async {
    try {
      final token = await _authHelper.getToken() ;
      final response = await _httpHelper.get(
        url: '${URLs.baseURL}/articles',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
      );
      if (response.statusCode < 400 && response.statusCode >= 200) {
        final responseDto = ResponseDto.fromMap(response.data);
        final articles = (responseDto.data as List<dynamic>)
            .map(
              (article) => ArticleDto.fromMap(article).toEntity(),
            )
            .toList();
        return Right(articles);
      } else {
        return Left(ArticlesFailure());
      }
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return Left(ArticlesFailure());
    }
  }
}
