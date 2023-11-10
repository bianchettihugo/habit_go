import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/presentation/state/habits_form_cubit.dart';
import 'package:habit_go/app/habits/presentation/state/habits_form_state.dart';
import 'package:habit_go/app/habits/presentation/widgets/habit_reminders_list.dart';
import 'package:habit_go/core/widgets/buttons/link_button.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';
import 'package:habit_go/core/widgets/inputs/time_input.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';
import '../../../../utils/test_utils.dart';

void main() {
  final state = HabitFormState();
  late HabitFormCubit habitFormCubit;

  setUp(() {
    habitFormCubit = MockHabitFormCubit();
  });

  tearDownAll(() {
    habitFormCubit.close();
  });

  testWidgets(
      'habits/presentation/widgets - renders CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(() => habitFormCubit.state).thenReturn(
      state.copyWith(
        status: HabitFormStatus.loading,
      ),
    );

    await tester.pumpWidgetWithApp(
      BlocProvider.value(
        value: habitFormCubit,
        child: const HabitRemindersList(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'habits/presentation/widgets - renders nothing when there are no reminders',
      (WidgetTester tester) async {
    when(() => habitFormCubit.state).thenReturn(
      state.copyWith(
        status: HabitFormStatus.success,
        reminders: [],
      ),
    );

    await tester.pumpWidgetWithApp(
      BlocProvider.value(
        value: habitFormCubit,
        child: const HabitRemindersList(),
      ),
    );

    expect(find.byType(SizedBox), findsOneWidget);
  });

  testWidgets('habits/presentation/widgets - renders reminders',
      (WidgetTester tester) async {
    final reminders = [
      DateTime(2022, 12, 31, 12, 0),
      DateTime(2022, 12, 31, 18, 0),
    ];
    when(() => habitFormCubit.state).thenReturn(
      state.copyWith(
        status: HabitFormStatus.success,
        reminders: reminders,
      ),
    );

    await tester.pumpWidgetWithApp(
      BlocProvider.value(
        value: habitFormCubit,
        child: const HabitRemindersList(),
      ),
    );

    expect(find.byType(TimeInput), findsNWidgets(reminders.length));
    expect(find.byType(IconButton), findsNWidgets(reminders.length));
    expect(find.byType(LinkButton), findsOneWidget);
    expect(
      find.byIcon(FeatherIcons.fi_delete),
      findsNWidgets(reminders.length),
    );
  });

  testWidgets(
      'habits/presentation/widgets - adds a reminder when "Add reminder" is tapped',
      (WidgetTester tester) async {
    registerFallbackValue(DateTime(2022, 12, 31, 18, 0));
    when(() => habitFormCubit.state).thenReturn(
      state.copyWith(
        status: HabitFormStatus.success,
        reminders: [
          DateTime(2022, 12, 31, 12, 0),
        ],
      ),
    );

    await tester.pumpWidgetWithApp(
      BlocProvider.value(
        value: habitFormCubit,
        child: const HabitRemindersList(),
      ),
    );

    await tester.tap(find.text('Add reminder'));

    verify(() => habitFormCubit.addReminder(any())).called(1);
  });

  testWidgets(
      'habits/presentation/widgets - removes a reminder when the delete button is tapped',
      (WidgetTester tester) async {
    final reminders = [
      DateTime(2022, 12, 31, 12, 0),
      DateTime(2022, 12, 31, 18, 0),
    ];
    when(() => habitFormCubit.state).thenReturn(
      state.copyWith(
        status: HabitFormStatus.success,
        reminders: reminders,
      ),
    );

    await tester.pumpWidgetWithApp(
      BlocProvider.value(
        value: habitFormCubit,
        child: const HabitRemindersList(),
      ),
    );

    await tester.tap(find.byIcon(FeatherIcons.fi_delete).first);

    verify(() => habitFormCubit.removeReminder(reminders.first)).called(1);
  });
}
