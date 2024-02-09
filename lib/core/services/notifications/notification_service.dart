import 'package:flutter/material.dart';

abstract class NotificationService {
  Future<bool> requestPermissions({required BuildContext context});
}
