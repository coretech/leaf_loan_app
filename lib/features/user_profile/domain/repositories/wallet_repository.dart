import 'package:dartz/dartz.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';

abstract class WalletRepository {
  Future<Either<WalletFailure, List<Wallet>>> getWallet();
}

class WalletFailure {}
