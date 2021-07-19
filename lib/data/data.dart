import 'package:flutter_dotenv/flutter_dotenv.dart';

String? checkUrl() {
  if (dotenv.env['ENVIRONMENT'] == 'PROD')
    return 'https://loan-api.leafglobal.tech/api/v1';
  else if (dotenv.env['ENVIRONMENT'] == 'DEV')
    return 'https://loan-dev.leafglobal.tech/api/v1';
  else if (dotenv.env['ENVIRONMENT'] == 'FEAT')
    return 'https://loan-feat.leafglobal.tech/api/v1';
  else
    return null;
}

Uri uriConverter(String url) {
  return Uri.parse(url);
}
