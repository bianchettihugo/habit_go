import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/inputs/time_input.dart';
import 'package:habit_go/core/widgets/labels/placeholder_label.dart';

import '../../../utils/test_utils.dart';

void main() {
  late final FocusNode focus;
  late final FocusNode focus2;
  late final FocusNode focus3;
  late final FocusNode focus4;

  setUpAll(() {
    focus = FocusNode();
    focus2 = FocusNode();
    focus3 = FocusNode();
    focus4 = FocusNode();
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

  testWidgets('core/widgets/inputs - time input formatter test',
      (tester) async {
    DateTime? time;
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            TimeInput(
              id: 'dt',
              focus: focus3,
              trailingIcon: Icons.ac_unit,
              leadingIcon: Icons.calendar_month,
              label: 'Test input',
            ),
            ElevatedButton(
              child: const Text('Continue'),
              onPressed: () {
                final result = DataFormState.of(context).fetchData();
                time = result!['dt'];
              },
            ),
          ],
        ),
      ),
    );

    focus3.requestFocus();
    await tester.tap(find.byType(TextField));
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));

    final now = TimeOfDay.now();
    final hours = now.hour.toString().padLeft(2, '0');
    final minutes = now.minute.toString().padLeft(2, '0');

    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton));

    expect(find.text('$hours:$minutes'), findsOneWidget);
    expect(time != null, true);
  });

  testWidgets('core/widgets/inputs - time input invalid formatter test',
      (tester) async {
    DateTime? time;
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) => Column(
          children: [
            TimeInput(
              id: 'dt',
              focus: focus4,
              trailingIcon: Icons.ac_unit,
              leadingIcon: Icons.calendar_month,
              label: 'Test input',
              initialValue: 'jsaodjoiqw:qwqw',
            ),
            ElevatedButton(
              child: const Text('Continue'),
              onPressed: () {
                final result = DataFormState.of(context).fetchData();
                time = result!['dt'];
              },
            ),
          ],
        ),
      ),
    );

    focus4.requestFocus();
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ElevatedButton));

    expect(time != null, true);
  });
}
