import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';

import '../../../../core/widgets/icons/feather_icons_icons.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const SettingsItem({
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: double.maxFinite,
        width: 45,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: context.theme.primaryColor,
            ),
          ),
        ),
      ),
      tileColor: context.theme.canvasColor,
      title: Text(
        title,
        style: context.text.bodyMedium,
      ),
      trailing: Icon(
        FeatherIcons.fi_chevrons_right,
        color: context.theme.colorScheme.onSurface,
      ),
      onTap: onPressed,
    );
  }
}
