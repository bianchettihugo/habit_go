import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/presentation/widgets/habit_form_app_bar.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';

import '../../../../utils/data.dart';
import '../../../../utils/test_utils.dart';

void main() {
  testWidgets('habits/presentation/widgets - renders title correctly',
      (WidgetTester tester) async {
    final habit = habitEntity;
    await tester.pumpWidgetWithApp(
      HabitFormAppBar(habit: habit),
    );
    expect(find.text('Edit habit'), findsOneWidget);
  });

  testWidgets('habits/presentation/widgets - renders new habit title correctly',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const HabitFormAppBar(habit: null),
    );
    expect(find.text('New habit'), findsOneWidget);
  });

  testWidgets('habits/presentation/widgets - renders actions correctly',
      (WidgetTester tester) async {
    final habit = habitEntity;
    await tester.pumpWidgetWithApp(
      MaterialApp(
        home: Scaffold(
          appBar: HabitFormAppBar(habit: habit),
        ),
      ),
    );
    expect(find.byIcon(FeatherIcons.fi_refresh_cw), findsOneWidget);
    expect(find.byIcon(FeatherIcons.fi_delete), findsOneWidget);
  });

  testWidgets(
      'habits/presentation/widgets - should not render actions for new habit',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const HabitFormAppBar(habit: null),
    );

    expect(find.byIcon(FeatherIcons.fi_refresh_cw), findsNothing);
    expect(find.byIcon(FeatherIcons.fi_delete), findsNothing);
  });

  testWidgets(
      'habits/presentation/widgets - should return result = reset when reset button is pressed',
      (WidgetTester tester) async {
    final habit = habitEntity;
    var result = {};
    await tester.pumpWidgetWithApp(
      ElevatedButton(
        onPressed: () async {
          result = await Navigator.push(
            tester.element(find.byType(ElevatedButton)),
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: HabitFormAppBar(
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
    await tester.tap(find.byIcon(FeatherIcons.fi_refresh_cw));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    expect(result, {'result': 'reset'});
  });

  testWidgets(
      'habits/presentation/widgets - should return result = delte when delete button is pressed',
      (WidgetTester tester) async {
    final habit = habitEntity;
    var result = {};
    await tester.pumpWidgetWithApp(
      ElevatedButton(
        onPressed: () async {
          result = await Navigator.push(
            tester.element(find.byType(ElevatedButton)),
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: HabitFormAppBar(
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
    await tester.tap(find.byIcon(FeatherIcons.fi_delete));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    expect(result, {'result': 'delete'});
  });
}
