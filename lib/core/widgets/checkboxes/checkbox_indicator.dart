import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';

class CheckboxIndicator extends StatefulWidget {
  const CheckboxIndicator({super.key});

  @override
  State<CheckboxIndicator> createState() => _CheckboxIndicatorState();
}

class _CheckboxIndicatorState extends State<CheckboxIndicator> {
  bool active = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 30), () {
        setState(() {
          active = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExcludeFocus(
      child: IgnorePointer(
        child: Checkbox(
          value: active,
          activeColor: Colors.transparent,
          checkColor: context.theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: BorderSide(
            width: 2,
            color: context.theme.canvasColor,
          ),
          onChanged: null,
        ),
      ),
    );
  }
}
