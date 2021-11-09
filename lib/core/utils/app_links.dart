import 'package:external_app_launcher/external_app_launcher.dart';

class AppLinks {
  static Future<void> launchApp() async {
    await LaunchApp.openApp(
      androidPackageName: 'com.leafglobalfintech.leaf_app',
      appStoreLink:
          'https://itunes.apple.com/in/app/pulse-secure/id1479058983?mt=8',
      iosUrlScheme: 'pulsesecure://com.leafglobalfintech.leaf_app',
    );
  }
}
