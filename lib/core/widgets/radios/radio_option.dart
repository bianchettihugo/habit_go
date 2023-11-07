import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';

class RadioOption<T> extends StatefulWidget {
  final Map<String, T> options;
  final Function(T) onChanged;

  const RadioOption({
    required this.options,
    required this.onChanged,
    super.key,
  });

  @override
  State<RadioOption<T>> createState() => _RadioOptionState<T>();
}

class _RadioOptionState<T> extends State<RadioOption<T>> {
  late T? _selectedOption;

  @override
  void initState() {
    _selectedOption = widget.options.values.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: context.theme.canvasColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.themeColors.grey,
          width: 2,
        ),
      ),
      child: Column(
        children: List.generate(widget.options.length, (index) {
          final key = widget.options.keys.elementAt(index);
          final value = widget.options.values.elementAt(index);
          return RadioListTile<T>(
            title: Text(
              key,
              style: context.text.bodyMedium,
            ),
            value: value,
            groupValue: _selectedOption,
            onChanged: (T? value) {
              if (value != null) {
                widget.onChanged(value);
                setState(() {
                  _selectedOption = value;
                });
              }
            },
          );
        }),
      ),
    );
  }
}
