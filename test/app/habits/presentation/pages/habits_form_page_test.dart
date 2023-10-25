import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/presentation/pages/habits_form_page.dart';
import 'package:habit_go/app/habits/presentation/widgets/habit_form_app_bar.dart';
import 'package:habit_go/core/widgets/buttons/button.dart';
import 'package:habit_go/core/widgets/inputs/number_input.dart';
import 'package:habit_go/core/widgets/inputs/text_input.dart';
import 'package:habit_go/core/widgets/inputs/weekday_input.dart';

import '../../../../utils/data.dart';
import '../../../../utils/test_utils.dart';

void main() {
  testWidgets('habits/presentation/pages - renders HabitFormAppBar',
      (tester) async {
    await tester.pumpWidgetWithApp(
      const HabitFormPage(),
    );

    expect(find.byType(HabitFormAppBar), findsOneWidget);
  });

  testWidgets(
      'habits/presentation/pages - renders TextInput with placeholder "Name"',
      (tester) async {
    await tester.pumpWidgetWithApp(
      const HabitFormPage(),
    );

    expect(find.widgetWithText(TextInput, 'Name'), findsOneWidget);
  });

  testWidgets(
      'habits/presentation/pages - renders NumberInput with label "How many times a day"',
      (tester) async {
    await tester.pumpWidgetWithApp(
      const HabitFormPage(),
    );

    expect(
      find.widgetWithText(NumberInput, 'How many times a day'),
      findsOneWidget,
    );
  });

  testWidgets('habits/presentation/pages - renders WeekDayInput',
      (tester) async {
    await tester.pumpWidgetWithApp(
      const HabitFormPage(),
    );

    expect(find.byType(WeekDayInput), findsOneWidget);
  });

  testWidgets(
      'habits/presentation/pages - renders Button with text "Create habit"',
      (tester) async {
    await tester.pumpWidgetWithApp(
      const HabitFormPage(),
    );

    expect(find.widgetWithText(Button, 'Create habit'), findsOneWidget);
    expect(find.text('New habit'), findsOneWidget);
  });

  testWidgets(
      'habits/presentation/pages - renders Button with text "Update habit" when habit is not null',
      (tester) async {
    final habit = habitEntity;
    await tester.pumpWidgetWithApp(
      MaterialApp(
        home: HabitFormPage(habit: habit),
      ),
    );

    expect(find.widgetWithText(Button, 'Update habit'), findsOneWidget);
    expect(find.text('Edit habit'), findsOneWidget);
  });

  testWidgets(
      'habits/presentation/pages - should return result = data when "Update habit" is pressed',
      (WidgetTester tester) async {
    final habit = habitEntity2;
    var result = {};
    await tester.pumpWidgetWithApp(
      ElevatedButton(
        onPressed: () async {
          result = await Navigator.push(
            tester.element(find.byType(ElevatedButton)),
            MaterialPageRoute(
              builder: (context) => Scaffold(
                body: HabitFormPage(
                  habit: habit,
                ),
              ),
            ),
          );
        },
        child: const Text('Go'),
      ),
    );

    await tester.tap(find.text('Go'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(NumberInput), '5');
    await tester.pump();
    await tester.tap(find.text('Update habit'));
    await tester.pumpAndSettle();

    expect(result, habitDataUpdate);
  });

  testWidgets(
      'habits/presentation/pages - should return result = data when "Create habit" is pressed',
      (WidgetTester tester) async {
    var result = {};
    await tester.pumpWidgetWithApp(
      ElevatedButton(
        onPressed: () async {
          result = await Navigator.push(
            tester.element(find.byType(ElevatedButton)),
            MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: HabitFormPage(),
              ),
            ),
          );
        },
        child: const Text('Go'),
      ),
    );

    await tester.tap(find.text('Go'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextInput), 'title');
    await tester.enterText(find.byType(NumberInput), '5');
    await tester.tap(find.byType(Checkbox).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create habit'));
    await tester.pumpAndSettle();

    expect(result, habitDataCreate);
  });
}
