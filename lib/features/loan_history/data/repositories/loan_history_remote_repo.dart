import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/abstractions/abstractions.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/data/dtos/dtos.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/loan_history/data/data.dart';
import 'package:loan_app/features/loan_history/domain/domain.dart';

class LoanHistoryRemoteRepo extends LoanHistoryRepository {
  final AuthHelper _authHelper = AuthIOC.authHelper();
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();
  @override
  Future<Either<LoanHistoryFailure, List<LoanData>>> getLoans() async {
    try {
      final _token = await _authHelper.getToken() ?? '';
      final response = await _httpHelper.get(
        url: '${URLs.baseURL}/loanservice/loans',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(_token),
        ]),
      );
      if (response.statusCode < 400 && response.statusCode >= 200) {
        final responseDto = ResponseDto.fromMap(response.data);
        final loanData = (responseDto.data as List<dynamic>).map(
          (data) {
            return LoanDataDto.fromMap(data).toEntity();
          },
        ).toList();
        return Right(loanData);
      } else {
        return Left(LoanHistoryFailure());
      }
    } catch (e) {
      return Left(LoanHistoryFailure());
    }
  }
}
