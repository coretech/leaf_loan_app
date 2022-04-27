import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:loan_app/authentication/helpers/helpers.dart';
import 'package:loan_app/authentication/ioc/ioc.dart';
import 'package:loan_app/core/core.dart';
import 'package:uuid/uuid.dart';

class CredoDataCollectionService implements ScoringDataCollectionService {
  final AuthHelper _authHelper = AuthIOC.authHelper();
  final HttpHelper _httpHelper = IntegrationIOC.httpHelper();

  @override
  Future<Either<ScoringFailure, String>> scrapeAndSubmitScoringData({
    required String url,
  }) async {
    if (kDebugMode) {
      return right('debug');
    }
    try {
      final credoMethodChannel =
          MethodChannel(MethodChannelNames.credoScraping);

      const uuid = Uuid();
      final referenceNumber = uuid.v4();
      const authKey = String.fromEnvironment('CREDO_AUTH_KEY');
      const credoUrl = String.fromEnvironment('CREDO_URL');
      late String storedReferenceNumber;
      final result = await credoMethodChannel.invokeMethod(
        'submitCredoLabsData',
        {
          'authKey': authKey,
          'referenceNumber': referenceNumber,
          'url': credoUrl,
        },
      );
      storedReferenceNumber = result.toString();
      await _submitCredoScore(storedReferenceNumber);
      return right(storedReferenceNumber);
    } on PlatformException {
      return left(
        ScoringFailure(
          scoringFailureReason: ScoringFailureReason.sdkIssue,
        ),
      );
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
