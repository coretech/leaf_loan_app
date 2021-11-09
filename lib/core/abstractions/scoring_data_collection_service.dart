import 'package:dartz/dartz.dart';

abstract class ScoringDataCollectionService {
  Future<Either<ScoringFailure, String>> scrapeAndSubmitScoringData({
    required String url,
  });
}

class ScoringFailure {}
