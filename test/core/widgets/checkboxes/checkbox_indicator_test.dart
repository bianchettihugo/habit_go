import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/checkboxes/checkbox_indicator.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets(
      'core/widgets/checkboxes - CheckboxIndicator should be inactive by default',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const CheckboxIndicator(),
    );

    final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(checkbox.value, false);

    await tester.pumpAndSettle();
  });

  testWidgets(
      'core/widgets/checkboxes - CheckboxIndicator should become active after a delay',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const CheckboxIndicator(),
    );

    await tester.pump(const Duration(milliseconds: 31));
    await tester.pumpAndSettle();

    final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
    expect(checkbox.value, true);

    await tester.pumpAndSettle();
  });
}
