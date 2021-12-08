import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/data/data.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/user_profile/data/dtos/dtos.dart';
import 'package:loan_app/features/user_profile/domain/entities/entities.dart';
import 'package:loan_app/features/user_profile/domain/repositories/repositories.dart';

class WalletRemoteRepository implements WalletRepository {
  final AuthHelper _authHelper = AuthIOC.authHelper();
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();
  @override
  Future<Either<WalletFailure, Wallet>> getWallet() async {
    try {
      final _token = await _authHelper.getToken() ?? '';
      final _response = await _httpHelper.get(
        url: '${URLs.baseURL}/walletservice/wallets',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(_token),
        ]),
        cacheAge: const Duration(minutes: 20),
      );
      final _responseDto = ResponseDto.fromMap(_response.data);
      final _walletDto = WalletDto.fromMap(_responseDto.data);
      final _wallet = _walletDto.toEntity();
      return Right(_wallet);
    } catch (e) {
      return left(WalletFailure());
    }
  }
}
