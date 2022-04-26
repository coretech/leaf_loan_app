import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/user_profile/data/dtos/dtos.dart';
import 'package:loan_app/features/user_profile/domain/entities/stat.dart';
import 'package:loan_app/features/user_profile/domain/repositories/repositories.dart';

class StatsRemoteRepository implements StatsRepository {
  final AuthHelper _authHelper = AuthIOC.authHelper();
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();

  @override
  Future<Either<StatFailure, List<Stat>>> getStats() async {
    try {
      final token = await _authHelper.getToken() ;
      final response = await _httpHelper.get(
        url: '${URLs.baseURL}/loanservice/statistics',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
      );
      if (response.statusCode < 400 && response.statusCode >= 200) {
        final responseDto = ResponseDto.fromMap(response.data);
        final stats = (responseDto.data as List<dynamic>).map(
          (data) {
            return StatDto.fromMap(data).toEntity();
          },
        ).toList();
        return Right(stats);
      } else {
        return Left(StatFailure());
      }
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return Left(StatFailure());
    }
  }
}
