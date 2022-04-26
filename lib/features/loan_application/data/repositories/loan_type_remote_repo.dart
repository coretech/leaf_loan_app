import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/domain/domain.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_application/domain/domain.dart';

class LoanTypeRemoteRepo implements LoanTypeRepository {
  final AuthHelper _authHelper = AuthIOC.authHelper();
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();
  @override
  Future<Either<LoanTypeError, List<LoanType>>> getLoanTypes() async {
    try {
      final token = await _authHelper.getToken() ;
      final response = await _httpHelper.get(
        url: '${URLs.baseURL}/loanservice/loantypes',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
        cacheAge: const Duration(minutes: 20),
      );
      if (response.statusCode < 400 && response.statusCode >= 200) {
        final responseDto = ResponseDto.fromMap(response.data);
        final loanTypes = (responseDto.data as List<dynamic>)
            .map(
              (loanType) => LoanTypeDto.fromMap(loanType).toEntity(),
            )
            .toList();
        return Right(loanTypes);
      } else {
        return Left(LoanTypeError());
      }
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return Left(LoanTypeError());
    }
  }
}
