import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/core.dart';
import 'package:loan_app/features/loan_application/domain/domain.dart';

class LoanApplicationRemoteRepo extends LoanApplicationRepository {
  final AuthHelper _authHelper = AuthIOC.authHelper();
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();

  @override
  Future<Either<LoanApplicationFailure, bool>> apply({
    required double amount,
    required String currencyId,
    required int duration,
    required String loanPurpose,
    required String loanTypeId,
    required String password,
  }) async {
    try {
      final token = await _authHelper.getToken() ;
      final roundedAmount = double.parse(amount.toStringAsFixed(2));
      final response = await _httpHelper.post(
        url: '${URLs.baseURL}/loanservice/loans',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
        data: {
          'amount': roundedAmount,
          'currencyid': currencyId,
          'duration': duration,
          'loanpurpose': loanPurpose,
          'loantypeid': loanTypeId,
          'password': password,
        },
      );
      if (response.statusCode < 400 && response.statusCode >= 200) {
        return const Right(true);
      } else {
        return Left(LoanApplicationFailure());
      }
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return Left(LoanApplicationFailure());
    }
  }

  @override
  Future<Either<LoanCancellationFailure, bool>> cancel({
    required String loanId,
    required String password,
  }) async {
    try {
      final token = await _authHelper.getToken() ;
      final response = await _httpHelper.delete(
        url: '${URLs.baseURL}/loanservice/loans/$loanId',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
          MapEntry('password', password),
        ]),
      );
      if (response.statusCode < 400 && response.statusCode >= 200) {
        return const Right(true);
      } else {
        return Left(LoanCancellationFailure());
      }
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return Left(LoanCancellationFailure());
    }
  }
}
