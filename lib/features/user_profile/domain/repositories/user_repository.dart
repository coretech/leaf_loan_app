import 'package:dartz/dartz.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

abstract class UserRepository {
  Future<Either<UserFailure, User>> getUser();
}

class UserFailure {}
