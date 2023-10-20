import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/checkboxes/option_checkbox.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets('core/widgets/checkboxes - renders Checkbox',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const OptionCheckbox(),
    );

    expect(find.byType(Checkbox), findsOneWidget);
  });

  testWidgets(
      'core/widgets/checkboxes - calls onChanged when Checkbox is tapped',
      (WidgetTester tester) async {
    bool? value;

    await tester.pumpWidgetWithApp(
      OptionCheckbox(
        onChanged: (newValue) {
          value = newValue;
        },
      ),
    );

    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    expect(value, true);
  });
}
