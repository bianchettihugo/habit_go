import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';

class ProgressCard extends StatefulWidget {
  final int value;
  final int total;
  final IconData icon;
  final String title;
  final String description;

  const ProgressCard({
    required this.value,
    required this.total,
    required this.icon,
    this.title = '',
    this.description = '',
    super.key,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ListTile(
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
                widget.icon,
                color: context.theme.primaryColor,
              ),
            ),
          ),
        ),
        tileColor: context.theme.canvasColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: context.text.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ' - ${widget.value.toString().padLeft(2, '0')} / ${widget.total}',
                  style: context.text.bodySmall?.copyWith(
                    color: context.theme.disabledColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              widget.description,
              style: context.text.bodySmall,
            ),
            const SizedBox(height: 10),
          ],
        ),
        subtitle: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 130,
            maxWidth: 140,
          ),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            tween: Tween<double>(
              begin: 0,
              end: widget.value / widget.total,
            ),
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              minHeight: 5,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
      ),
    );
  }
}
