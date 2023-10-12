import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final Color color;

  final VoidCallback onTap;

  const ColorButton({
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: color, width: 1.5),
        ),
        child: const Center(
          child: SizedBox(),
        ),
      ),
    );
  }
}
