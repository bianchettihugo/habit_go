import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';

class CustomInputDecorator {
  static InputDecoration decoration({
    required BuildContext context,
    bool error = false,
    bool focused = false,
  }) {
    return InputDecoration(
      alignLabelWithHint: true,
      hoverColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      filled: true,
      fillColor: error ? context.themeColors.red50 : context.theme.canvasColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: context.themeColors.grey,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: context.theme.primaryColor,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: context.theme.colorScheme.error,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: context.themeColors.red75,
          width: 2,
        ),
      ),
      errorStyle: context.text.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: context.theme.colorScheme.error,
      ),
    );
  }
}
