import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/presentation/state/habits_form_state.dart';

void main() {
  test('habits/presentation/state - equality test', () {
    final date = DateTime.now();
    final state1 = HabitFormState(
      status: HabitFormStatus.loading,
      reminders: [date],
      error: null,
    );
    state1.hashCode;
    final state2 = HabitFormState(
      status: HabitFormStatus.loading,
      reminders: [date],
      error: null,
    );
    final state3 = HabitFormState(
      status: HabitFormStatus.success,
      reminders: [date],
      error: null,
    );
    final state4 = HabitFormState(
      status: HabitFormStatus.loading,
      reminders: [
        date.add(
          const Duration(days: 1),
        ),
      ],
      error: null,
    );
    final state5 = HabitFormState(
      status: HabitFormStatus.loading,
      reminders: [date],
      error: 'An error occurred',
    );

    expect(state1, equals(state2));
    expect(state1, isNot(equals(state3)));
    expect(state1, isNot(equals(state4)));
    expect(state1, isNot(equals(state5)));
  });

  test(
      'habits/presentation/state - copyWith creates a new instance with updated values',
      () {
    final date = DateTime.now();
    final state1 = HabitFormState(
      status: HabitFormStatus.loading,
      reminders: [date],
      error: null,
    );
    state1.copyWith();
    state1.copyWith(
      status: HabitFormStatus.success,
      reminders: [date.add(const Duration(days: 1))],
      error: 'An error occurred',
    );
    final state2 = state1.copyWith(
      status: HabitFormStatus.success,
      reminders: [date.add(const Duration(days: 1))],
      error: 'An error occurred',
    );

    expect(state1.status, equals(HabitFormStatus.loading));
    expect(state1.reminders, equals([date]));
    expect(state1.error, isNull);

    expect(state2.status, equals(HabitFormStatus.success));
    expect(
      state2.reminders,
      equals([date.add(const Duration(days: 1))]),
    );
    expect(state2.error, equals('An error occurred'));
  });
}
