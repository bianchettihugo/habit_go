import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/inputs/time_input.dart';
import 'package:habit_go/core/widgets/labels/placeholder_label.dart';

import '../../../utils/test_utils.dart';

void main() {
  late final FocusNode focus;
  late final FocusNode focus2;

  setUpAll(() {
    focus = FocusNode();
    focus2 = FocusNode();
  });

  testWidgets('core/widgets/inputs - time input test', (tester) async {
    await tester.pumpWidgetWithApp(
      const TimeInput(
        trailingIcon: Icons.ac_unit,
        leadingIcon: Icons.calendar_month,
      ),
    );

    expect(find.byType(TimeInput), findsOneWidget);
    expect(find.byType(PlaceholderLabel), findsNothing);
  });

  testWidgets('core/widgets/inputs - time input test with label',
      (tester) async {
    await tester.pumpWidgetWithApp(
      const TimeInput(
        initialValue: 'LL',
        label: 'Test input',
      ),
    );

    expect(find.byType(TimeInput), findsOneWidget);
    expect(find.byType(PlaceholderLabel), findsOneWidget);
    expect(find.text('Test input'), findsOneWidget);
  });

  testWidgets('core/widgets/inputs - time input functional test',
      (tester) async {
    await tester.pumpWidgetWithApp(
      TimeInput(
        focus: focus,
        trailingIcon: Icons.ac_unit,
        leadingIcon: Icons.calendar_month,
        label: 'Test input',
      ),
    );

    focus.requestFocus();
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));

    final now = TimeOfDay.now();
    final hours = now.hour.toString().padLeft(2, '0');
    final minutes = now.minute.toString().padLeft(2, '0');

    expect(find.text('$hours:$minutes'), findsOneWidget);
  });

  testWidgets('core/widgets/inputs - time input error test', (tester) async {
    await tester.pumpWidgetWithApp(
      TimeInput(
        label: 'Test input',
        focus: focus2,
        trailingIcon: Icons.ac_unit,
        leadingIcon: Icons.calendar_month,
        error: true,
      ),
    );

    focus2.requestFocus();
    await tester.pump();

    expect(find.byType(TimeInput), findsOneWidget);
  });
}
