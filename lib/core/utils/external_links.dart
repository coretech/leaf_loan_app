import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalLinks {
  static Future<void> launchApp() async {
    await LaunchApp.openApp(
      androidPackageName: 'com.leafglobalfintech.leaf_app',
      appStoreLink:
          'https://itunes.apple.com/in/app/pulse-secure/id1479058983?mt=8',
      iosUrlScheme: 'pulsesecure://com.leafglobalfintech.leaf_app',
    );
  }

  static Future<void> callPhoneNumber(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static Future<void> sendEmail(String email) async {
    final url = 'mailto:$email';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static Future<void> openWhatsapp(String number) async {
    final whatsappURlAndroid = 'whatsapp://send?phone=$number';
    final whatsappURLIos = 'https://wa.me/$number';
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatsappURLIos)) {
        await launch(whatsappURLIos, forceSafariVC: false);
      } else {
        await launch(whatsappURLIos);
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        await launch(whatsappURLIos);
      }
    }
  }
}
