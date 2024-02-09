import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';

class PermissionModal extends StatelessWidget {
  final List<NotificationPermission> lockedPermissions;
  final Function(BuildContext) onAllowPressed;

  const PermissionModal({
    super.key,
    required this.lockedPermissions,
    required this.onAllowPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.theme.colorScheme.background,
      title: const Text(
        'Permission for notifications',
        textAlign: TextAlign.center,
        maxLines: 2,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notification_important_sharp,
            color: context.theme.primaryColor,
            size: 48,
          ),
          const SizedBox(height: 10),
          const Text(
            'We need permissions to send reminders.',
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Deny',
            style: TextStyle(
              color: context.theme.colorScheme.onSurface,
              fontSize: 18,
            ),
          ),
        ),
        TextButton(
          onPressed: () => onAllowPressed(context),
          child: Text(
            'Allow',
            style: TextStyle(
              color: context.theme.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
