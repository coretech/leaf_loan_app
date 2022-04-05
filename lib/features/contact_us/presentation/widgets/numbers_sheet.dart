import 'package:flutter/material.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/i18n/i18n.dart';

class NumbersSheet extends StatelessWidget {
  const NumbersSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Leaf Phone Numbers'.tr(),
            style: Theme.of(context).textTheme.headline6,
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
            endIndent: 20,
            indent: 20,
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: <Widget>[
                ListTile(
                  onTap: () => ExternalLinks.callPhoneNumber('+243979085600'),
                  subtitle: const Text('+243979085600'),
                  title: const Text('Democratic Republic of the Congo'),
                  trailing: Icon(
                    Icons.call_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                ListTile(
                  onTap: () => ExternalLinks.callPhoneNumber('+254207641420'),
                  subtitle: const Text('+254207641420'),
                  title: const Text('Kenya'),
                  trailing: Icon(
                    Icons.call_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                ListTile(
                  onTap: () => ExternalLinks.callPhoneNumber('+250786816336'),
                  subtitle: const Text('+250786816336'),
                  title: const Text('Rwanda'),
                  trailing: Icon(
                    Icons.call_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                ListTile(
                  onTap: () => ExternalLinks.callPhoneNumber('+256206300895'),
                  subtitle: const Text('+256206300895'),
                  title: const Text('Uganda'),
                  trailing: Icon(
                    Icons.call_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
