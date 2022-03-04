import 'package:dartz/dartz.dart';
import 'package:loan_app/features/features.dart';

abstract class StatsRepository {
  Future<Either<StatFailure, List<Stat>>> getStats();
}

class StatFailure {}
