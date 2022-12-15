import 'package:permission_handler/permission_handler.dart';

abstract class PermissionsState {}

class PermissionsInitial extends PermissionsState {}

class RequestingPermissions extends PermissionsState {}

class PermissionsGranted extends PermissionsState {}

class PermissionsDenied extends PermissionsState {
  PermissionsDenied(this.deniedPermissions);

  final List<Permission> deniedPermissions;
}

class PermissionsError extends PermissionsState {
  PermissionsError(this.message);

  final String message;
}
