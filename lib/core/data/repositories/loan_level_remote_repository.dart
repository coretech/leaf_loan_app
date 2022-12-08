// ignore_for_file: avoid_dynamic_calls

import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/authentication.dart';
import 'package:loan_app/core/core.dart';

class LoanLevelRemoteRepository implements LoanLevelRepository {
  final AuthHelper _authHelper = AuthIOC.authHelper();
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();

  @override
  Future<Either<LoanLevelFailure, LoanLevel>> getLoanLevel() async {
    try {
      final token = await _authHelper.getToken();
      final response = await _httpHelper.get(
        url: '${URLs.baseURL}/loanservice/levels/customers',
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
      );
      if (response.isOk) {
        final responseDto = ResponseDto.fromMap(response.data);
        final level = LoanLevelMapper.fromMap(responseDto.data['level']);
        return right(level);
      } else {
        return left(LoanLevelFailure());
      }
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return left(LoanLevelFailure());
    }
  }
}
