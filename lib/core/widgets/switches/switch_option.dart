import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:habit_go/core/widgets/inputs/input_decorator.dart';

class SwitchOption extends StatelessWidget {
  final String id;
  final String title;
  final Future<bool> Function()? conditional;

  const SwitchOption({
    required this.id,
    required this.title,
    this.conditional,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DataFormSwitch(
      text: title,
      id: id,
      decoration: CustomInputDecorator.containerDecoration(context: context),
      conditional: conditional,
    );
  }
}
