import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:habit_go/core/widgets/inputs/input_decorator.dart';

class SwitchOption extends StatelessWidget {
  final String id;
  final String title;
  final Future<bool> Function()? conditional;
  final Function(bool)? onChanged;
  final bool active;

  const SwitchOption({
    required this.id,
    required this.title,
    this.conditional,
    this.onChanged,
    this.active = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DataFormSwitch(
      text: title,
      id: id,
      active: active,
      decoration: CustomInputDecorator.containerDecoration(context: context),
      conditional: conditional,
      onChanged: onChanged,
    );
  }
}
