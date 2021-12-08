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
      final _token = await _authHelper.getToken() ?? '';
      final response = await _httpHelper.post(
        url: '${URLs.baseURL}/loanservice/loans',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(_token),
        ]),
        data: {
          'amount': amount,
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
    } catch (e) {
      return Left(LoanApplicationFailure());
    }
  }
}
