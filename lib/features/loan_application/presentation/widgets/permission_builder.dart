import 'package:flutter/material.dart';
import 'package:loan_app/features/loan_application/presentation/providers/permissions/permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class PermissionBuilder extends StatelessWidget {
  const PermissionBuilder({
    Key? key,
    required this.onNotAllAllowed,
    required this.onError,
    required this.onGranted,
    required this.provider,
  }) : super(key: key);
  final Widget Function(BuildContext, Map<Permission, PermissionStatus>)
      onNotAllAllowed;
  final Widget Function(BuildContext, String) onError;
  final Widget Function(BuildContext) onGranted;
  final PermissionsProvider provider;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      builder: (context, _) {
        return Selector<PermissionsProvider, PermissionsState>(
          selector: (context, provider) => provider.state,
          builder: (context, state, _) {
            if (state is PermissionsGranted) {
              return onGranted(context);
            }

            if (state is NotAllPermissionsGranted) {
              return onNotAllAllowed(context, state.permissionStatuses);
            }

            if (state is PermissionsError) {
              return onError(context, state.message);
            }

            return Column(
              children: const [
                Spacer(),
                CircularProgressIndicator(),
                SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
                Text('Checking if required permissions are granted...'),
                Spacer(),
              ],
            );
          },
        );
      },
    );
  }
}
