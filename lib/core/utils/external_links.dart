import 'dart:io';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  static Future<void> sendEmail(String email) async {
    final url = 'mailto:$email';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  static Future<void> openWhatsapp(String number) async {
    final whatsappURlAndroid = 'whatsapp://send?phone=$number';
    final whatsappURLIos = 'https://wa.me/$number';
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrlString(whatsappURLIos)) {
        await launchUrlString(
          whatsappURLIos,
          mode: LaunchMode.externalNonBrowserApplication,
        );
      } else {
        await launchUrlString(whatsappURLIos);
      }
    } else {
      // android , web
      if (await canLaunchUrlString(whatsappURlAndroid)) {
        await launchUrlString(
          whatsappURlAndroid,
          mode: LaunchMode.externalNonBrowserApplication,
        );
      } else {
        await launchUrlString(whatsappURLIos);
      }
    }
  }
}
