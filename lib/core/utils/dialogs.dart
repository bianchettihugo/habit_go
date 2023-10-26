import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';

class Dialogs {
  static Future<bool> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String description,
    String? cancelText,
    String? continueText,
  }) async {
    var result = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: context.text.bodyLarge,
          ),
          content: Text(
            description,
            style: context.text.bodyMedium,
          ),
          actions: [
            TextButton(
              child: Text(
                cancelText ?? 'Cancel',
                style: context.text.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                result = false;
              },
            ),
            TextButton(
              child: Text(
                continueText ?? 'Continue',
                style: context.text.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                result = true;
              },
            ),
          ],
        );
      },
    );
    return result;
  }

  static Future<void> showAlertDialog({
    required BuildContext context,
    required String title,
    required String description,
    String? continueText,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: context.text.bodyLarge,
          ),
          content: Text(
            description,
            style: context.text.bodyMedium,
          ),
          actions: [
            TextButton(
              child: Text(
                continueText ?? 'OK',
                style: context.text.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.theme.primaryColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
