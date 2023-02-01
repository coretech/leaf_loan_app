import 'dart:developer';

import 'package:credoappsdk_common/credoappsdk.dart';
import 'package:dartz/dartz.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/core.dart';
import 'package:uuid/uuid.dart';

class CredoDataCollectionService implements ScoringDataCollectionService {
  final AuthHelper _authHelper = AuthIOC.authHelper();
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();

  @override
  Future<Either<ScoringFailure, String>> scrapeAndSubmitScoringData() async {
    try {
      const authKey = String.fromEnvironment('CREDO_AUTH_KEY');
      const url = String.fromEnvironment('CREDO_URL');
      const uuid = Uuid();
      final referenceNumber = uuid.v4();
      final result = await Credoappsdk.execute(url, authKey, referenceNumber);
      if (result.isFailure) {
        log('Error: ${result.code} ${result.message}');
        return left(
          ScoringFailure(
            scoringFailureReason: ScoringFailureReason.sdkIssue,
          ),
        );
      } else {
        await _submitCredoScore(referenceNumber);
        return right(result.code);
      }
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
      return left(
        ScoringFailure(
          scoringFailureReason: ScoringFailureReason.sdkIssue,
        ),
      );
    }
  }

  Future<void> _submitCredoScore(String referenceId) async {
    try {
      final token = await _authHelper.getToken();
      final userId = await _authHelper.getUserId();
      final _ = await _httpHelper.post(
        url: '${URLs.baseURL}/loanservice/references',
        data: {
          'credoid': referenceId,
          'customerid': userId,
        },
        headers: Map.fromEntries([
          TokenUtil.generateBearer(token),
        ]),
      );
    } catch (e, stacktrace) {
      await IntegrationIOC.logger().logError(e, stacktrace);
    }
  }
}
