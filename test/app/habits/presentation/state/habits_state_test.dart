import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/presentation/state/habits_state.dart';

import '../../../../utils/data.dart';

void main() {
  test('habits/presentation/state - test HabitState equality and copy', () {
    final habit = HabitState(
      habits: [habitEntity],
      status: HabitStatus.loading,
      error: 'error',
      updateIndex: 1,
    );

    expect(
      habit.hashCode,
      HabitState(
        habits: [habitEntity],
        status: HabitStatus.loading,
        error: 'error',
        updateIndex: 1,
      ).hashCode,
    );
    expect(
      habit.copyWith(),
      HabitState(
        habits: [habitEntity],
        status: HabitStatus.loading,
        error: 'error',
        updateIndex: 1,
      ),
    );
  });
}
