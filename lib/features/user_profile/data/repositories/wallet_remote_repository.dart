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
  Future<Either<WalletFailure, List<Wallet>>> getWallet() async {
    try {
      final token = await _authHelper.getToken() ;
      final response = await _httpHelper.get(
        url: '${URLs.baseURL}/walletservice/wallets',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
      );
      final responseDto = ResponseDto.fromMap(response.data);
      final _wallets = (responseDto.data as List<dynamic>)
          .map(
            (walletDto) => WalletDto.fromMap(walletDto).toEntity(),
          )
          .toList();
      return Right(_wallets);
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return left(WalletFailure());
    }
  }
}
