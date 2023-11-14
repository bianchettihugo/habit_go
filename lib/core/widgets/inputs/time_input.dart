import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/inputs/input_decorator.dart';
import 'package:habit_go/core/widgets/labels/placeholder_label.dart';

class TimeInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focus;
  final String hint;
  final String label;
  final String? placeholder;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final String? Function(String?)? validator;
  final String Function(String)? formatter;
  final Map<bool, String> Function(String?)? validate;
  final String? id;
  final String? initialValue;
  final void Function(String)? onChanged;
  final bool autoFocus;
  final bool showVisibilityButton;
  final bool error;

  const TimeInput({
    super.key,
    this.controller,
    this.focus,
    this.hint = '',
    this.label = '',
    this.placeholder,
    this.leadingIcon,
    this.trailingIcon,
    this.validator,
    this.validate,
    this.formatter,
    this.id,
    this.initialValue,
    this.onChanged,
    this.autoFocus = true,
    this.showVisibilityButton = true,
    this.error = false,
  });

  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  late TextEditingController controller;
  late FocusNode focus;
  late bool error;
  bool focused = false;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
    }
    error = widget.error;
    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
    }
    focus = widget.focus ?? FocusNode();
    focus.addListener(() {
      setState(() {
        focused = focus.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label.isNotEmpty)
          PlaceholderLabel(
            label: widget.label,
          ),
        DataFormTextField(
          id: widget.id ?? '',
          controller: controller,
          readOnly: true,
          formatter: (date) {
            return DateTime.now().copyWith(
              hour: int.tryParse(date?.split(':').first ?? '') ?? 0,
              minute: int.tryParse(date?.split(':').last ?? '') ?? 0,
            );
          },
          onTap: () async {
            final time = await showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            );
            if (time != null) {
              final hours = time.hour.toString().padLeft(2, '0');
              final minutes = time.minute.toString().padLeft(2, '0');
              controller.text = '$hours:$minutes';

              if (context.mounted) {
                FocusScope.of(context).unfocus();
              }
            }
          },
          focusNode: focus,
          validator: widget.validator,
          validate: widget.validate,
          onChanged: widget.onChanged,
          textAlignVertical: TextAlignVertical.center,
          autofocus: widget.autoFocus,
          decoration: CustomInputDecorator.decoration(
            context: context,
            error: error,
            focused: focused,
          ).copyWith(
            floatingLabelBehavior: widget.placeholder != null
                ? FloatingLabelBehavior.auto
                : FloatingLabelBehavior.never,
            label: Text(
              widget.placeholder ?? widget.hint,
              style: context.text.bodyMedium?.copyWith(
                color: error
                    ? context.theme.colorScheme.error
                    : focused
                        ? context.theme.primaryColor
                        : context.theme.hintColor,
              ),
            ),
          ),
          style: context.text.bodyMedium?.copyWith(
            color: context.theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    focus.dispose();
    super.dispose();
  }
}
