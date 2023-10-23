import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/checkboxes/option_checkbox.dart';
import 'package:habit_go/core/widgets/inputs/weekday_input.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets('core/widgets/inputs - should render correctly',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const WeekDayInput(),
    );

    expect(find.text('Select the days of the week'), findsOneWidget);
    expect(find.byType(DayButton), findsNWidgets(7));
  });

  testWidgets(
      'core/widgets/inputs - should show error message when no day is selected',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) {
          return Column(
            children: [
              const WeekDayInput(),
              ElevatedButton(
                onPressed: () {
                  DataFormState.of(context).fetchData();
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      ),
    );

    for (var i = 0; i < 7; i++) {
      await tester.tap(find.byType(OptionCheckbox).at(i));
      await tester.pumpAndSettle();
    }

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('You must select at least one day'), findsOneWidget);
  });

  testWidgets(
      'core/widgets/inputs - should not show error message when at least one day is selected',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      DataForm(
        builder: (context) {
          return Column(
            children: [
              const WeekDayInput(),
              ElevatedButton(
                onPressed: () {
                  DataFormState.of(context).fetchData();
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      ),
    );

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('You must select at least one day'), findsNothing);
  });
}
