import 'package:flutter/material.dart';
import 'package:habit_go/core/services/notifications/notification_service.dart';

abstract class CheckHabitReminderPermissionsUsecase {
  Future<bool> call({
    required BuildContext context,
  });
}

class CheckHabitReminderPermissionsUsecaseImpl
    extends CheckHabitReminderPermissionsUsecase {
  final NotificationService _notificationService;

  CheckHabitReminderPermissionsUsecaseImpl({
    required NotificationService notificationService,
  }) : _notificationService = notificationService;

  @override
  Future<bool> call({
    required BuildContext context,
  }) async {
    return _notificationService.requestPermissions(context: context);
  }
}
