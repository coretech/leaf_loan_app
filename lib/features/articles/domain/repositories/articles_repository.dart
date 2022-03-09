import 'package:dartz/dartz.dart';
import 'package:loan_app/core/domain/entities/entities.dart';

abstract class ArticlesRepository {
  Future<Either<ArticlesFailure, List<Article>>> getArticles();
}

class ArticlesFailure {}
