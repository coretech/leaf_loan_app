import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:loan_app/core/constants/constants.dart';
import 'package:loan_app/core/ioc/ioc.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/features/contact_us/presentation/presentation.dart';
import 'package:loan_app/i18n/i18n.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  static const String routeName = '/contact-us';

  String get whatsAppPhoneNumber => IntegrationIOC.remoteConfig.getString(
        RemoteConfigKeys.whatsAppContactNumber,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: Text('Contact Us'.tr()),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          ListTile(
            leading: const Icon(
              FontAwesome5.whatsapp,
              color: Color(0xff43D854),
            ),
            onTap: () => ExternalLinks.openWhatsapp(whatsAppPhoneNumber),
            subtitle: Text(whatsAppPhoneNumber),
            title: const Text('WhatsApp'),
          ),
          ListTile(
            leading: const Icon(
              Icons.email_outlined,
              color: Color(0xffea4335),
            ),
            onTap: () => ExternalLinks.sendEmail('info@leafglobalfintech.com'),
            title: Text('Email'.tr()),
            subtitle: const Text('info@leafglobalfintech.com'),
          ),
          ListTile(
            leading: Icon(
              Icons.phone_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onTap: () => _showNumbersSheet(context),
            title:  Text('Phone'.tr()),
            subtitle:  Text('Tap to see phone numbers'.tr()),
          ),
        ],
      ),
    );
  }

  void _showNumbersSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const NumbersSheet(),
    );
  }
}
