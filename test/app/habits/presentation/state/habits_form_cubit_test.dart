import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/usecases/check_habit_reminder_permissions_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habit_reminders_usecase.dart';
import 'package:habit_go/app/habits/presentation/state/habits_form_cubit.dart';
import 'package:habit_go/app/habits/presentation/state/habits_form_state.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  final date = DateTime.now();
  const failure = Failure(message: 'Error');
  late FetchHabitReminderUsecase fetchHabitReminderUsecase;
  late CheckHabitReminderPermissionsUsecase checkHabitReminderPermissions;
  late HabitFormCubit habitFormCubit;

  setUp(() {
    fetchHabitReminderUsecase = MockFetchHabitReminderUsecase();
    checkHabitReminderPermissions = MockCheckHabitReminderPermissionsUsecase();
    habitFormCubit = HabitFormCubit(
      fetchHabitReminders: fetchHabitReminderUsecase,
      checkHabitReminderPermissions: checkHabitReminderPermissions,
    );
  });

  tearDown(() {
    habitFormCubit.close();
  });

  const habitId = 1;
  final habitReminders = [
    date,
    date.add(const Duration(hours: 1)),
  ];

  test('habits/presentation/state - initial state is correct', () {
    expect(habitFormCubit.state, HabitFormState());
  });

  blocTest<HabitFormCubit, HabitFormState>(
    'habits/presentation/state - emits [loading, success] when fetchHabitReminders is called successfully',
    build: () {
      when(() => fetchHabitReminderUsecase(habitId: habitId))
          .thenAnswer((_) async => Result.success(habitReminders));
      return habitFormCubit;
    },
    act: (cubit) => cubit.fetchHabitReminders(habitId: habitId),
    expect: () => [
      HabitFormState(status: HabitFormStatus.loading),
      HabitFormState(
        status: HabitFormStatus.success,
        reminders: habitReminders,
      ),
    ],
  );

  blocTest<HabitFormCubit, HabitFormState>(
    'habits/presentation/state - emits [loading, error] when fetchHabitReminders fails',
    build: () {
      when(() => fetchHabitReminderUsecase(habitId: habitId)).thenAnswer(
        (_) async => Result.failure(failure),
      );
      return habitFormCubit;
    },
    act: (cubit) => cubit.fetchHabitReminders(habitId: habitId),
    expect: () => [
      HabitFormState(status: HabitFormStatus.loading),
      HabitFormState(
        status: HabitFormStatus.error,
        error: failure.toString(),
        reminders: [],
      ),
    ],
  );

  blocTest<HabitFormCubit, HabitFormState>(
    'habits/presentation/state - emits [reminders: [reminder]] when addReminder is called',
    build: () => habitFormCubit,
    act: (cubit) => cubit.addReminder(date),
    expect: () => [
      HabitFormState(reminders: [date]),
    ],
  );

  blocTest<HabitFormCubit, HabitFormState>(
    'habits/presentation/state - emits [reminders: []] when clearReminders is called',
    build: () => habitFormCubit,
    act: (cubit) => cubit.clearReminders(),
    expect: () => [
      HabitFormState(reminders: []),
    ],
  );

  blocTest<HabitFormCubit, HabitFormState>(
    'habits/presentation/state - emits [reminders: []] when removeReminder is called with a reminder',
    build: () => habitFormCubit,
    seed: () => HabitFormState(reminders: habitReminders),
    act: (cubit) => cubit.removeReminder(date),
    expect: () => [
      HabitFormState(
        reminders: [date.add(const Duration(hours: 1))],
      ),
    ],
  );
}
