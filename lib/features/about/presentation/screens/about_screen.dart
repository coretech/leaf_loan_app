import 'package:flutter/material.dart';
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
        title: const Text('About'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.description_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Coming soon'),
                ),
              );
            },
            title: Text(
              'Terms and Conditions',
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
                'https://leafglobalfintech.github.io/leaf_loans'
                '/privacy_policy/',
              );
            },
            title: const Text(
              'Privacy Policy',
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.contact_support_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Coming soon'),
                ),
              );
            },
            title: Text(
              'Contact us',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.share_outlined,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Coming soon'),
                ),
              );
            },
            title: Text(
              'Share App',
              style: Theme.of(context).textTheme.subtitle1,
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
                    text: 'Leaf Loans version ',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  TextSpan(
                    text: versionName,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  TextSpan(
                    text: ' © Leaf Global Fintech',
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
