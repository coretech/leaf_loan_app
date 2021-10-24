import 'package:flutter/services.dart';
import 'package:loan_app/core/core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class CredoDataCollectionService implements ScoringDataCollectionService {
  @override
  Future<String> scrapeAndSubmitScoringData({
    required String url,
  }) async {
    var credoMethodChannel = MethodChannel(MethodChannelNames.credoScraping);

    await [
      Permission.location,
      Permission.contacts,
      Permission.calendar,
      Permission.storage,
      Permission.mediaLibrary,
    ].request();

    try {
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
      return storedReferenceNumber;
    } on PlatformException catch (e) {
      throw e;
    } on Exception catch (e) {
      throw e;
    }
  }
}
