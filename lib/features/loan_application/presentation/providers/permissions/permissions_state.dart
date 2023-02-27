import 'package:permission_handler/permission_handler.dart';

abstract class PermissionsState {}

class PermissionsInitial extends PermissionsState {}

class RequestingPermissions extends PermissionsState {}

class PermissionsGranted extends PermissionsState {}

class NotAllPermissionsGranted extends PermissionsState {
  NotAllPermissionsGranted(this.permissionStatuses);

  final Map<Permission, PermissionStatus> permissionStatuses;
}

class PermissionsError extends PermissionsState {
  PermissionsError(this.message);

  final String message;
}
