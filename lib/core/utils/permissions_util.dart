import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

abstract class PermissionsUtil {
  static Future<Map<Permission, PermissionStatus>> request(
    List<Permission> permissions,
  ) async {
    final givenPermissions = await permissions.request();
    return givenPermissions;
  }

  static String? getName(Permission permission) {
    if (Platform.isAndroid) {
      return _androidPermissionNames[permission];
    } else {
      return _iOSPermissionNames[permission];
    }
  }

  static final Map<Permission, String> _androidPermissionNames = {
    Permission.calendar: 'Calendar',
    Permission.camera: 'Camera',
    Permission.contacts: 'Contacts',
    Permission.location: 'Location',
    Permission.locationAlways: 'Background Location',
    Permission.locationWhenInUse: 'Foreground Location',
    Permission.microphone: 'Microphone',
    Permission.phone: 'Phone',
    Permission.sensors: 'Body Sensors',
    Permission.sms: 'SMS',
    Permission.speech: 'Microphone',
    Permission.storage: 'Files and Media',
    Permission.ignoreBatteryOptimizations: 'Ignore Battery Optimizations',
    Permission.notification: 'Notification',
    Permission.accessMediaLocation: 'Collected Geographic Locations',
    Permission.activityRecognition: 'Activity Recognition',
    Permission.bluetooth: 'Bluetooth',
    Permission.manageExternalStorage: 'External Storage',
    Permission.systemAlertWindow: 'Overlay Over Apps',
    Permission.requestInstallPackages: 'Install Packages',
    Permission.accessNotificationPolicy: 'Access Notification Policy',
    Permission.bluetoothScan: 'Bluetooth Scan',
    Permission.bluetoothAdvertise: 'Bluetooth Advertise',
    Permission.bluetoothConnect: 'Bluetooth Connect'
  };

  static final Map<Permission, String> _iOSPermissionNames = {
    Permission.calendar: 'Calendar (Events)',
    Permission.camera: 'Photos (Camera Roll and Camera)',
    Permission.contacts: 'AddressBook',
    Permission.location: 'Location',
    Permission.locationAlways: 'Background Location',
    Permission.locationWhenInUse: 'Foreground Location',
    Permission.mediaLibrary: 'Media Library',
    Permission.microphone: 'Microphone',
    Permission.photos: 'Photos',
    Permission.photosAddOnly: 'Photos',
    Permission.reminders: 'Reminders',
    Permission.sensors: 'Body Sensors',
    Permission.speech: 'Speech',
    Permission.storage: 'Storage',
    Permission.notification: 'Notification',
    Permission.bluetooth: 'Bluetooth',
    Permission.appTrackingTransparency: 'App Tracking Transparency',
  };
}
