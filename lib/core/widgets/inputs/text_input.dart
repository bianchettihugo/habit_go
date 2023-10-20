import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/inputs/input_decorator.dart';
import 'package:habit_go/core/widgets/labels/placeholder_label.dart';

class TextInput extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focus;
  final String hint;
  final String label;
  final String? placeholder;
  final bool obscure;
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

  const TextInput({
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
    this.obscure = false,
    this.autoFocus = true,
    this.showVisibilityButton = true,
    this.error = false,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late TextEditingController controller;
  late FocusNode focus;
  late bool obscure;
  late bool error;
  bool focused = false;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    error = widget.error;
    if (widget.initialValue != null) {
      controller.text = widget.initialValue!;
    }
    focus = widget.focus ?? FocusNode();
    obscure = widget.obscure;
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
          obscureText: obscure,
          controller: controller,
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
