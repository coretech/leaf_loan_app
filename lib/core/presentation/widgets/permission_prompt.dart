import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loan_app/core/utils/utils.dart';
import 'package:loan_app/i18n/i18n.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionPrompt extends StatefulWidget {
  const PermissionPrompt({
    Key? key,
    required this.permissions,
    required this.onPermissionAction,
  }) : super(key: key);
  final Map<Permission, PermissionStatus> permissions;
  final VoidCallback onPermissionAction;

  @override
  State<PermissionPrompt> createState() => _PermissionPromptState();
}

class _PermissionPromptState extends State<PermissionPrompt>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.onPermissionAction();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SvgPicture.asset(
            'assets/images/access_denied.svg',
            height: 150,
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          Expanded(
            flex: 4,
            child: _buildPermissionsPermissions(context),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await PermissionsUtil.request(
                widget.permissions.keys.toList(),
              );
              if (result.isNotEmpty) {
                if (result.values
                    .contains(PermissionStatus.permanentlyDenied)) {
                  // ignore: use_build_context_synchronously
                  onPermissionPermanentlyDenied(context, single: false);
                }
                widget.onPermissionAction();
              }
            },
            child: Text('Grant All'.tr()),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionsPermissions(BuildContext context) {
    return Column(
      children: [
        const Text(
          'By enabling access to Contacts, Calendar, '
          'Storage, and Installed applications, we will collect data '
          'to better evaluate your application for Leaf Loans. '
          'This information is only accessed once and collected '
          'in the form of metadata, not personal data. '
          'The metadata is shared and used by Credolab only '
          'to make a more accurate credit decision.',
        ),
        Flexible(
          child: ListView(
            children: _buildPermissionTiles(context),
          ),
        ),
      ],
    );
  }

  Future<Widget> _getPermissionAction(
    BuildContext context,
    Permission permission,
  ) async {
    if (await permission.isDenied) {
      return TextButton(
        onPressed: () async {
          final result = await PermissionsUtil.request([permission]);
          if (result.isNotEmpty &&
              result[permission] == PermissionStatus.permanentlyDenied) {
            // ignore: use_build_context_synchronously
            onPermissionPermanentlyDenied(context);
          }
          widget.onPermissionAction();
        },
        child: Text(
          'Grant'.tr(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return const Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  List<Widget> _buildPermissionTiles(BuildContext context) {
    return widget.permissions.entries
        .where((element) => PermissionsUtil.getName(element.key) != null)
        .map(
          (e) => ListTile(
            title: Text(PermissionsUtil.getName(e.key)!),
            trailing: FutureBuilder<Widget>(
              future: _getPermissionAction(context, e.key),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        )
        .toList();
  }

  void onPermissionPermanentlyDenied(
    BuildContext context, {
    bool single = true,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => _PermissionDeniedSheet(
        onPermissionAction: widget.onPermissionAction,
        singlePermission: single,
      ),
    );
  }
}

class _PermissionDeniedSheet extends StatelessWidget {
  const _PermissionDeniedSheet({
    Key? key,
    required this.onPermissionAction,
    required this.singlePermission,
  }) : super(key: key);
  final VoidCallback onPermissionAction;
  final bool singlePermission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/images/access_denied.svg',
              height: 120,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              singlePermission
                  ? 'Looks like you have denied this permission before. '
                          'Go to app settings and grant it manually'
                      .tr()
                  : 'Looks like there are some permissions you '
                      'have denied. '
                      'Go to app settings and grant them manually.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () async {
                await openAppSettings();
                onPermissionAction();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              child: const Text('Open App Settings'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
