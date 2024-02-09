// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/domain/usecases/add_reminder_usecase.dart';
import 'package:habit_go/app/reminders/domain/usecases/delete_reminder_usecase.dart';
import 'package:habit_go/app/reminders/domain/usecases/fetch_reminders_usecase.dart';
import 'package:habit_go/app/reminders/domain/usecases/set_habit_reminders_usecase.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_bloc.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_events.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_state.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late FetchRemindersUsecase fetchRemindersUsecase;
  late DeleteReminderUsecase deleteReminderUsecase;
  late AddReminderUsecase addReminderUsecase;
  late SetHabitRemindersUsecase setHabitRemindersUsecase;
  late RemindersBloc remindersBloc;

  setUp(() {
    fetchRemindersUsecase = MockFetchRemindersUsecase();
    deleteReminderUsecase = MockDeleteReminderUsecase();
    addReminderUsecase = MockAddReminderUsecase();
    setHabitRemindersUsecase = MockSetHabitRemindersUsecase();
    remindersBloc = RemindersBloc(
      fetchRemindersUsecase: fetchRemindersUsecase,
      deleteReminderUsecase: deleteReminderUsecase,
      addReminderUsecase: addReminderUsecase,
      setHabitRemindersUsecase: setHabitRemindersUsecase,
    );
  });

  tearDown(() {
    remindersBloc.close();
  });

  final reminder1 = ReminderEntity(
    id: 1,
    title: 'Reminder 1',
    time: DateTime(2021, 11, 11),
  );
  final reminder2 = ReminderEntity(
    id: 2,
    title: 'Reminder 2',
    time: DateTime(2021, 11, 11),
  );
  final reminder3 = ReminderEntity(
    id: 3,
    title: 'Reminder 3',
    time: DateTime(2021, 11, 11),
  );

  blocTest<RemindersBloc, ReminderState>(
    'reminder/presentation/state - emits [ReminderState(loading), ReminderState(loaded)] when ReminderLoadEvent is added and FetchRemindersUsecase returns success',
    build: () {
      when(() => fetchRemindersUsecase()).thenAnswer(
        (_) async => Result.success([reminder1, reminder2]),
      );
      return remindersBloc;
    },
    act: (bloc) => bloc.add(ReminderLoadEvent()),
    expect: () => [
      ReminderState(status: ReminderStatus.loading),
      ReminderState(
        reminders: [reminder1, reminder2],
        status: ReminderStatus.loaded,
      ),
    ],
  );

  blocTest<RemindersBloc, ReminderState>(
    'reminder/presentation/state - emits [ReminderState(loading), ReminderState(toastError)] when ReminderLoadEvent is added and FetchRemindersUsecase returns failure',
    build: () {
      when(() => fetchRemindersUsecase()).thenAnswer(
        (_) async => Result.failure(const Failure(message: 'Error message')),
      );
      return remindersBloc;
    },
    act: (bloc) => bloc.add(ReminderLoadEvent()),
    expect: () => [
      ReminderState(status: ReminderStatus.loading),
      ReminderState(
        status: ReminderStatus.error,
        error: 'Error message',
      ),
    ],
  );

  blocTest<RemindersBloc, ReminderState>(
    'reminder/presentation/state - emits [ReminderState(loading), ReminderState(loaded)] when ReminderAddEvent is added and AddReminderUsecase returns success',
    build: () {
      when(() => addReminderUsecase(reminder3)).thenAnswer(
        (_) async => Result.success(reminder3),
      );
      return remindersBloc;
    },
    seed: () => ReminderState(reminders: [reminder1, reminder2]),
    act: (bloc) => bloc.add(ReminderAddEvent(reminder3)),
    expect: () => [
      ReminderState(
        reminders: [reminder1, reminder2, reminder3],
        status: ReminderStatus.loaded,
      ),
    ],
  );

  blocTest<RemindersBloc, ReminderState>(
    'reminder/presentation/state - emits [ReminderState(loading), ReminderState(toastError)] when ReminderAddEvent is added and AddReminderUsecase returns failure',
    build: () {
      when(() => addReminderUsecase(reminder3)).thenAnswer(
        (_) async => Result.failure(const Failure(message: 'Error message')),
      );
      return remindersBloc;
    },
    seed: () => ReminderState(reminders: [reminder1, reminder2]),
    act: (bloc) => bloc.add(ReminderAddEvent(reminder3)),
    expect: () => [
      ReminderState(
        status: ReminderStatus.toastError,
        error: 'Error message',
      ),
    ],
  );

  blocTest<RemindersBloc, ReminderState>(
    'reminder/presentation/state - emits [ReminderState(loading), ReminderState(loaded)] when ReminderDeleteEvent is added and DeleteReminderUsecase returns success',
    build: () {
      when(() => deleteReminderUsecase(reminder2)).thenAnswer(
        (_) async => Result.success(reminder2),
      );
      return remindersBloc;
    },
    seed: () => ReminderState(reminders: [reminder1, reminder2]),
    act: (bloc) => bloc.add(ReminderDeleteEvent(reminder2)),
    expect: () => [
      ReminderState(
        reminders: [reminder1],
        status: ReminderStatus.loaded,
      ),
    ],
  );

  blocTest<RemindersBloc, ReminderState>(
    'reminder/presentation/state - emits [ReminderState(loading), ReminderState(toastError)] when ReminderDeleteEvent is added and DeleteReminderUsecase returns failure',
    build: () {
      when(() => deleteReminderUsecase(reminder2)).thenAnswer(
        (_) async => Result.failure(const Failure(message: 'Error message')),
      );
      return remindersBloc;
    },
    seed: () => ReminderState(reminders: [reminder1, reminder2]),
    act: (bloc) => bloc.add(ReminderDeleteEvent(reminder2)),
    expect: () => [
      ReminderState(
        status: ReminderStatus.toastError,
        error: 'Error message',
      ),
    ],
  );

  blocTest<RemindersBloc, ReminderState>(
    'reminder/presentation/state - emits [ReminderState(loading), ReminderState(loaded)] when ReminderSetEvent is added and SetHabitRemindersUsecase returns success',
    build: () {
      when(
        () => setHabitRemindersUsecase(
          habitId: any(named: 'habitId'),
          reminders: any(named: 'reminders'),
        ),
      ).thenAnswer(
        (_) async => Result.success([reminder3]),
      );
      return remindersBloc;
    },
    seed: () => ReminderState(reminders: [reminder1, reminder2]),
    act: (bloc) => bloc.add(
      ReminderSetEvent(
        habitId: 1,
        reminders: [reminder3],
      ),
    ),
    expect: () => [
      ReminderState(
        reminders: [reminder3],
        status: ReminderStatus.loaded,
      ),
    ],
  );

  blocTest<RemindersBloc, ReminderState>(
    'reminder/presentation/state - emits [ReminderState(loading), ReminderState(toastError)] when ReminderSetEvent is added and SetHabitRemindersUsecase returns failure',
    build: () {
      when(
        () => setHabitRemindersUsecase(
          habitId: any(named: 'habitId'),
          reminders: any(named: 'reminders'),
        ),
      ).thenAnswer(
        (_) async => Result.failure(const Failure(message: 'Error message')),
      );
      return remindersBloc;
    },
    seed: () => ReminderState(reminders: [reminder1, reminder2]),
    act: (bloc) => bloc.add(
      ReminderSetEvent(
        habitId: 1,
        reminders: [reminder3],
      ),
    ),
    expect: () => [
      ReminderState(
        status: ReminderStatus.toastError,
        error: 'Error message',
      ),
    ],
  );
}
