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
    required String pinCode,
  }) async {
    try {
      final _token = await _authHelper.getToken() ?? '';
      final response = await _httpHelper.post(
        url: '${URLs.baseURL}/loanservice/loantypes',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(_token),
        ]),
        cacheAge: const Duration(minutes: 20),
        data: {
          'amount': amount,
          'currencyid': currencyId,
          'duration': duration,
          'loanpurpose': loanPurpose,
          'loantypeid': loanTypeId,
          'pincode': pinCode
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
