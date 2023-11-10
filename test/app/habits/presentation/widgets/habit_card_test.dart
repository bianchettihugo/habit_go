import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habit_reminders_usecase.dart';
import 'package:habit_go/app/habits/presentation/pages/habits_form_page.dart';
import 'package:habit_go/app/habits/presentation/widgets/habit_card.dart';
import 'package:habit_go/core/services/dependency/dependency_service.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:habit_go/core/widgets/checkboxes/checkbox_indicator.dart';
import 'package:habit_go/core/widgets/inputs/number_input.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';
import '../../../../utils/test_utils.dart';

void main() {
  final usecase = MockFetchHabitReminderUsecase();
  late HabitEntity habit;

  setUp(() {
    Dependency.register<FetchHabitReminderUsecase>(
      usecase,
    );
    habit = habitEntity2;
  });

  tearDown(() {
    GetIt.I.unregister<FetchHabitReminderUsecase>();
  });

  testWidgets('habits/presentation/widgets - renders HabitCard',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      HabitCard(habit),
    );

    expect(find.byType(HabitCard), findsOneWidget);
  });

  testWidgets('habits/presentation/widgets - increments progress when tapped',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      HabitCard(habit),
    );

    final progressIndicatorFinder = find.byType(LinearProgressIndicator);
    final progressIndicator =
        tester.widget<LinearProgressIndicator>(progressIndicatorFinder);
    final initialProgress = progressIndicator.value;

    expect(find.byType(CheckboxIndicator), findsNothing);
    expect(find.text('1/4'), findsOneWidget);
    expect(find.text('2/4'), findsNothing);

    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();

    expect(find.text('2/4'), findsOneWidget);
    expect(find.text('1/4'), findsNothing);

    final updatedProgressIndicator =
        tester.widget<LinearProgressIndicator>(progressIndicatorFinder);
    final updatedProgress = updatedProgressIndicator.value;

    expect(updatedProgress! > initialProgress!, true);
  });

  testWidgets('habits/presentation/widgets - show check sign when complete',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      HabitCard(habit),
    );

    expect(find.byType(CheckboxIndicator), findsNothing);

    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();

    expect(find.byType(CheckboxIndicator), findsOneWidget);
  });

  testWidgets(
      'habits/presentation/widgets - should call onClosed when closed with data',
      (WidgetTester tester) async {
    when(() => usecase.call(habitId: 0)).thenAnswer(
      (invocation) async => Result.success([]),
    );
    var data = {};
    await tester.pumpWidgetWithApp(
      HabitCard(
        habit,
        onClosed: (d) {
          data = d;
        },
      ),
    );

    await tester.longPress(find.byType(ListTile));
    await tester.pumpAndSettle();

    expect(find.byType(HabitFormPage), findsOneWidget);

    await tester.enterText(find.byType(NumberInput), '5');
    await tester.pump();
    await tester.tap(find.text('Update habit'));
    await tester.pumpAndSettle();

    expect(data, habitDataUpdate2);
  });

  testWidgets('habits/presentation/widgets - should call onPressed when tapped',
      (WidgetTester tester) async {
    var pressed = false;
    await tester.pumpWidgetWithApp(
      HabitCard(
        habit,
        onPressed: () {
          pressed = true;
        },
      ),
    );

    await tester.tap(find.byType(ListTile));
    await tester.pumpAndSettle();

    expect(pressed, true);
  });
}
