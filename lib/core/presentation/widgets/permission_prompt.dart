import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionPrompt extends StatelessWidget {
  const PermissionPrompt({
    Key? key,
    required this.permissions,
  }) : super(key: key);
  final Map<Permission, PermissionStatus> permissions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/access_denied.svg',
            height: 150,
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          _buildDeniedPermissions(context),
        ],
      ),
    );
  }

  Widget _buildDeniedPermissions(BuildContext context) {
    final names = permissions.keys
        .map(PermissionsUtil.getName)
        .where((e) => e != null)
        .toList();
    final joinedNames = names.join(', ');
    return Column(
      children: [
        Text(
          'Leaf Loans requires the following permissions to collect metadata '
                  'from your device and generate an alternate Credit Score:'
              .tr(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            joinedNames,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'The collected metadata is only used for Credit Score '
                  'generation purposes.'
              .tr(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'You will have to go to app settings in order to grant '
                  'Leaf Loans the mentioned permissions.'
              .tr(),
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
        TextButton(
          onPressed: () {
            openAppSettings();
            Navigator.of(context).pop();
          },
          child: Text('Open App Settings'.tr()),
        )
      ],
    );
  }
}
