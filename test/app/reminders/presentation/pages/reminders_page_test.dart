// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/presentation/pages/reminders_page.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_bloc.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_state.dart';
import 'package:habit_go/app/reminders/presentation/widgets/reminder_card.dart';
import 'package:habit_go/core/widgets/errors/error_widget.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';
import '../../../../utils/test_utils.dart';

void main() {
  late RemindersBloc remindersBloc;

  setUp(() {
    remindersBloc = MockReminderBloc();
  });

  testWidgets('reminder/presentation/pages - renders the title',
      (WidgetTester tester) async {
    when(() => remindersBloc.state).thenReturn(
      ReminderState(status: ReminderStatus.loading),
    );

    await tester.pumpWidgetWithApp(
      BlocProvider.value(
        value: remindersBloc,
        child: const RemindersPage(),
      ),
    );

    expect(find.text('Reminders'), findsOneWidget);
  });

  testWidgets('reminder/presentation/pages - renders the loading indicator',
      (WidgetTester tester) async {
    when(() => remindersBloc.state).thenReturn(
      ReminderState(status: ReminderStatus.loading),
    );

    await tester.pumpWidgetWithApp(
      BlocProvider.value(
        value: remindersBloc,
        child: const RemindersPage(),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('reminder/presentation/pages - renders the error widget',
      (WidgetTester tester) async {
    when(() => remindersBloc.state).thenReturn(
      ReminderState(status: ReminderStatus.error),
    );

    await tester.pumpWidgetWithApp(
      BlocProvider.value(
        value: remindersBloc,
        child: const RemindersPage(),
      ),
    );

    expect(find.byType(CustomErrorWidget), findsOneWidget);

    await tester.tap(find.text('Try again'));
  });

  testWidgets('reminder/presentation/pages - renders the reminder cards',
      (WidgetTester tester) async {
    final reminders = [
      ReminderEntity(
        id: 1,
        title: 'Reminder 1',
        time: DateTime.now().copyWith(hour: 10, minute: 0),
        days: List.generate(7, (index) => 0),
      ),
      ReminderEntity(
        id: 2,
        title: 'Reminder 2',
        time: DateTime.now().copyWith(hour: 14, minute: 30),
        days: List.generate(7, (index) => 0),
      ),
    ];

    when(() => remindersBloc.state).thenReturn(
      ReminderState(status: ReminderStatus.loaded, reminders: reminders),
    );

    await tester.pumpWidgetWithApp(
      BlocProvider.value(
        value: remindersBloc,
        child: const RemindersPage(),
      ),
    );

    expect(find.byType(ReminderCard), findsNWidgets(2));
  });
}
