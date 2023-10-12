import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';

class Button extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function() onTap;

  const Button({
    required this.text,
    required this.onTap,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ButtonStyle(
        visualDensity: VisualDensity.comfortable,
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColor,
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(double.infinity, 56),
        ),
      ),
      icon: icon != null
          ? Transform.translate(
              offset: const Offset(-5, -0.7),
              child: Icon(icon, size: 24),
            )
          : const SizedBox.shrink(),
      label: Text(
        text,
        style: context.text.bodyMedium?.copyWith(
          color: context.theme.colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
