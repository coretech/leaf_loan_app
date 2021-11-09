import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:loan_app/core/core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class CredoDataCollectionService implements ScoringDataCollectionService {
  @override
  Future<Either<ScoringFailure, String>> scrapeAndSubmitScoringData({
    required String url,
  }) async {
    const String mode = String.fromEnvironment('MODE');
    if (mode == 'debug') {
      return right('debug');
    }
    try {
      var credoMethodChannel = MethodChannel(MethodChannelNames.credoScraping);

      await [
        Permission.location,
        Permission.contacts,
        Permission.calendar,
        Permission.storage,
        Permission.mediaLibrary,
      ].request();

      var uuid = Uuid();
      final referenceNumber = uuid.v4();
      const authKey = String.fromEnvironment('CREDO_AUTH_KEY');
      const credoUrl = String.fromEnvironment('CREDO_URL');
      late String storedReferenceNumber;
      await credoMethodChannel.invokeMethod(
        'submitCredoLabsData',
        {
          'authKey': authKey,
          'referenceNumber': referenceNumber,
          'url': credoUrl,
        },
      ).then((result) {
        storedReferenceNumber = result.toString();
      });
      return right(storedReferenceNumber);
    } on PlatformException {
      return left(ScoringFailure());
    } catch (_) {
      return left(ScoringFailure());
    }
  }
}
