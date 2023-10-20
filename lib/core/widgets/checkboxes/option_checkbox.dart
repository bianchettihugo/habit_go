import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';

class OptionCheckbox extends StatefulWidget {
  final bool active;
  // ignore: avoid_positional_boolean_parameters
  final Function(bool)? onChanged;
  final Color? borderColor;

  const OptionCheckbox({
    this.active = false,
    this.onChanged,
    this.borderColor,
    super.key,
  });

  @override
  State<OptionCheckbox> createState() => _OptionCheckboxState();
}

class _OptionCheckboxState extends State<OptionCheckbox> {
  late bool active;

  @override
  void initState() {
    active = widget.active;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: active,
      activeColor: context.theme.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: BorderSide(
        width: 2,
        color: widget.borderColor ?? context.theme.hintColor,
      ),
      onChanged: (value) {
        setState(() {
          active = value ?? false;
        });

        if (widget.onChanged != null) {
          widget.onChanged?.call(value ?? false);
        }
      },
    );
  }
}
