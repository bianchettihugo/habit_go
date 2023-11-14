import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:habit_go/core/services/notifications/notification_service.dart';
import 'package:habit_go/core/values/keys.dart';
import 'package:habit_go/core/widgets/modals/permission_modal_widget.dart';

class NotificationServiceImpl extends NotificationService {
  final AwesomeNotifications _awesomeNotifications;

  NotificationServiceImpl({required AwesomeNotifications awesomeNotifications})
      : _awesomeNotifications = awesomeNotifications;

  @override
  Future<bool> requestPermissions({required BuildContext context}) async {
    final permissionList = [
      NotificationPermission.Sound,
      NotificationPermission.Vibration,
    ];

    var permissionsAllowed = await _awesomeNotifications.checkPermissionList(
      channelKey: Keys.notificationChannel,
      permissions: permissionList,
    );

    if (permissionsAllowed.length == permissionList.length) return true;

    final permissionsNeeded =
        permissionList.toSet().difference(permissionsAllowed.toSet()).toList();

    final lockedPermissions =
        await _awesomeNotifications.shouldShowRationaleToRequest(
      channelKey: Keys.notificationChannel,
      permissions: permissionsNeeded,
    );

    if (lockedPermissions.isEmpty) {
      await _awesomeNotifications.requestPermissionToSendNotifications(
        channelKey: Keys.notificationChannel,
        permissions: permissionsNeeded,
      );

      permissionsAllowed = await _awesomeNotifications.checkPermissionList(
        channelKey: Keys.notificationChannel,
        permissions: permissionsNeeded,
      );
    } else if (context.mounted) {
      await showDialog(
        context: context,
        builder: (context) => PermissionModal(
          lockedPermissions: lockedPermissions,
          onAllowPressed: (context) async {
            await _awesomeNotifications.requestPermissionToSendNotifications(
              channelKey: Keys.notificationChannel,
              permissions: lockedPermissions,
            );

            permissionsAllowed =
                await _awesomeNotifications.checkPermissionList(
              channelKey: Keys.notificationChannel,
              permissions: lockedPermissions,
            );

            if (context.mounted) Navigator.pop(context);
          },
        ),
      );
    }

    return permissionsAllowed.length == permissionList.length;
  }
}
