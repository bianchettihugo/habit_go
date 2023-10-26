import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/inputs/input_decorator.dart';
import 'package:habit_go/core/widgets/labels/placeholder_label.dart';

class NumberInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focus;
  final String label;
  final IconData? leadingIcon;
  final String? Function(String?)? validator;
  final dynamic Function(String?)? formatter;
  final Map<bool, String> Function(String?)? validate;
  final String? id;
  final String? initialValue;
  final void Function(String)? onChanged;
  final bool autoFocus;
  final bool error;

  const NumberInput({
    super.key,
    this.controller,
    this.focus,
    this.label = '',
    this.leadingIcon,
    this.validator,
    this.validate,
    this.formatter,
    this.id,
    this.initialValue,
    this.onChanged,
    this.autoFocus = true,
    this.error = false,
  });

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  late TextEditingController controller;
  late FocusNode focus;
  late bool error;
  bool focused = false;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    error = widget.error;
    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
    } else {
      controller.text = '1';
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
          keyboardType: TextInputType.number,
          focusNode: focus,
          validator: widget.validator,
          validate: widget.validate,
          onChanged: widget.onChanged,
          textAlignVertical: TextAlignVertical.center,
          autofocus: widget.autoFocus,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          formatter: widget.formatter,
          decoration: CustomInputDecorator.decoration(
            context: context,
            error: error,
            focused: focused,
          ).copyWith(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    key: const ValueKey('number_input_down'),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: context.theme.colorScheme.onSurface,
                    ),
                    onPressed: () {
                      final value = int.tryParse(controller.text);
                      if (!focus.hasFocus) focus.requestFocus();
                      if (value != null && value > 1) {
                        controller.text = (value - 1).toString();
                      }
                    },
                  ),
                ),
                Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    key: const ValueKey('number_input_up'),
                    icon: Icon(
                      Icons.keyboard_arrow_up,
                      color: context.theme.colorScheme.onSurface,
                    ),
                    onPressed: () {
                      final value = int.tryParse(controller.text);
                      if (!focus.hasFocus) focus.requestFocus();
                      if (value != null) {
                        controller.text = (value + 1).toString();
                      }
                    },
                  ),
                ),
              ],
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
