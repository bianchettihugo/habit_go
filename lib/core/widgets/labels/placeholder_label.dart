import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';

class PlaceholderLabel extends StatelessWidget {
  final String label;
  final bool error;
  final bool focused;

  const PlaceholderLabel({
    this.label = '',
    this.error = false,
    this.focused = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 2,
        bottom: 5,
      ),
      child: Text(
        label,
        style: context.text.labelMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: error
              ? context.theme.colorScheme.error
              : focused
                  ? context.theme.primaryColor
                  : null,
        ),
      ),
    );
  }
}
