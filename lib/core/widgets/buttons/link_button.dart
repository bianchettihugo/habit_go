import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function() onTap;

  const LinkButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: icon != null
          ? Transform.translate(
              offset: const Offset(3, 0),
              child: Icon(
                icon,
                size: 22,
                color: Theme.of(context).primaryColor,
              ),
            )
          : const SizedBox.shrink(),
      label: Text(
        text,
        style: context.text.bodyMedium?.copyWith(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
