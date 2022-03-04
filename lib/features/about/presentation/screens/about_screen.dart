import 'package:flutter/material.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static const routeName = '/about';

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late PackageInfo packageInfo;
  String versionName = 'v';
  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        title: Text('About'.tr()),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.description_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onTap: () async {
              await launch(
                'https://leafglobalfintech.com/leaf-loans-terms/',
              );
            },
            title: Text(
              'Terms and Conditions'.tr(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.privacy_tip_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onTap: () async {
              await launch(
                'https://leafglobalfintech.com/leaf-loans-privacy-policy/',
              );
            },
            title: Text(
              'Privacy Policy'.tr(),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyText2,
                children: [
                  TextSpan(
                    text: 'Leaf Loans'.tr(),
                    style: Theme.of(context).textTheme.caption,
                  ),
                  TextSpan(
                    text: ' $versionName ',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  TextSpan(
                    text: '© Leaf Global Fintech'.tr(),
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionName = packageInfo.version;
    });
  }
}
