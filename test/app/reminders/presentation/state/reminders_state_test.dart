import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_state.dart';

import '../../../../utils/data.dart';

void main() {
  test(
      'reminder/presentation/state - should create a HabitState instance with default values',
      () {
    final habitState = ReminderState();

    expect(habitState.reminders, []);
    expect(habitState.status, ReminderStatus.loading);
    expect(habitState.error, '');
  });

  test(
      'reminder/presentation/state - should create a HabitState instance with given values',
      () {
    final reminders = [
      ReminderEntity(
        id: 1,
        title: 'Reminder 1',
        time: DateTime(2021, 11, 11),
      ),
      ReminderEntity(
        id: 2,
        title: 'Reminder 2',
        time: DateTime(2021, 11, 11),
      ),
    ];
    final habitState = ReminderState(
      reminders: reminders,
      status: ReminderStatus.loaded,
      error: 'Error message',
    );

    expect(habitState.reminders, reminders);
    expect(habitState.status, ReminderStatus.loaded);
    expect(habitState.error, 'Error message');
  });

  test(
      'reminder/presentation/state - should return true when two HabitState instances are equal',
      () {
    final reminders = [
      ReminderEntity(
        id: 1,
        title: 'Reminder 1',
        time: DateTime(2021, 11, 11),
      ),
      ReminderEntity(
        id: 2,
        title: 'Reminder 2',
        time: DateTime(2021, 11, 11),
      ),
    ];
    final habitState1 = ReminderState(
      reminders: reminders,
      status: ReminderStatus.loaded,
      error: 'Error message',
    );
    final habitState2 = ReminderState(
      reminders: reminders,
      status: ReminderStatus.loaded,
      error: 'Error message',
    );

    expect(habitState1 == habitState2, true);
  });

  test(
      'reminder/presentation/state - should return false when two HabitState instances are not equal',
      () {
    final reminders1 = [
      ReminderEntity(
        id: 1,
        title: 'Reminder 1',
        time: DateTime(2021, 11, 11),
      ),
      ReminderEntity(
        id: 2,
        title: 'Reminder 2',
        time: DateTime(2021, 11, 11),
      ),
    ];
    final reminders2 = [
      ReminderEntity(
        id: 1,
        title: 'Reminder 1',
        time: DateTime(2021, 11, 11),
      ),
      ReminderEntity(
        id: 2,
        title: 'Reminder 2',
        time: DateTime(2021, 11, 11),
      ),
      ReminderEntity(
        id: 3,
        title: 'Reminder 3',
        time: DateTime(2021, 11, 11),
      ),
    ];
    final habitState1 = ReminderState(
      reminders: reminders1,
      status: ReminderStatus.loaded,
      error: 'Error message',
    );
    final habitState2 = ReminderState(
      reminders: reminders2,
      status: ReminderStatus.loaded,
      error: 'Error message',
    );

    expect(habitState1 == habitState2, false);
  });

  test('reminder/presentation/state - should return the correct hash code', () {
    final reminders = [
      ReminderEntity(
        id: 1,
        title: 'Reminder 1',
        time: DateTime(2021, 11, 11),
      ),
      ReminderEntity(
        id: 2,
        title: 'Reminder 2',
        time: DateTime(2021, 11, 11),
      ),
    ];
    final habitState = ReminderState(
      reminders: reminders,
      status: ReminderStatus.loaded,
      error: 'Error message',
    );

    expect(habitState.hashCode, isA<int>());
  });

  test(
      'reminder/presentation/state - should return a new instance with updated values',
      () {
    reminderEntity.copyWith();
    final reminders1 = [
      ReminderEntity(
        id: 1,
        title: 'Reminder 1',
        time: DateTime(2021, 11, 11),
      ),
      reminderEntity.copyWith(
        id: 2,
        title: 'Reminder 2',
        time: DateTime(2021, 11, 11),
      ),
    ];
    final reminders2 = [
      ReminderEntity(
        id: 1,
        title: 'Reminder 1',
        time: DateTime(2021, 11, 11),
      ),
      ReminderEntity(
        id: 2,
        title: 'Reminder 2',
        time: DateTime(2021, 11, 11),
      ),
      ReminderEntity(
        id: 3,
        title: 'Reminder 3',
        time: DateTime(2021, 11, 11),
      ),
    ];
    final habitState1 = ReminderState(
      reminders: reminders1,
      status: ReminderStatus.loaded,
      error: 'Error message',
    );
    final habitState2 = habitState1.copyWith(
      reminders: reminders2,
      status: ReminderStatus.error,
      error: 'New error message',
    );

    habitState1.copyWith();
    habitState1.copyWith(
      error: 'a',
      status: ReminderStatus.error,
      reminders: [],
    );

    expect(habitState2.reminders, reminders2);
    expect(habitState2.status, ReminderStatus.error);
    expect(habitState2.error, 'New error message');
  });
}
