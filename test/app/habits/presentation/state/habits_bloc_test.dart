// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/usecases/add_habit_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/clear_habits_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habits_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/reset_habit_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/save_habit_usecase.dart';
import 'package:habit_go/app/habits/presentation/state/habits_bloc.dart';
import 'package:habit_go/app/habits/presentation/state/habits_event.dart';
import 'package:habit_go/app/habits/presentation/state/habits_state.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late FetchHabitsUsecase fetchHabitsUsecase;
  late DeleteHabitUsecase deleteHabitsUsecase;
  late SaveHabitUsecase saveHabitsUsecase;
  late ResetHabitProgressUsecase resetHabitUsecase;
  late AddHabitProgressUsecase addHabitProgressUsecase;
  late ClearHabitsProgressUsecase clearHabitProgressUsecase;

  setUp(() {
    fetchHabitsUsecase = MockFetchHabitsUsecase();
    deleteHabitsUsecase = MockDeleteHabitUsecase();
    saveHabitsUsecase = MockSaveHabitUsecase();
    resetHabitUsecase = MockResetHabitProgressUsecase();
    addHabitProgressUsecase = MockAddHabitProgressUsecase();
    clearHabitProgressUsecase = MockClearHabitsProgressUsecase();
  });

  final habit1 = habitEntity.copyWith(id: 1, title: 'Habit 1');
  final habit2 = habitEntity.copyWith(id: 2, title: 'Habit 2');
  final habits = [habit1, habit2];

  final habit1d = {
    'id': 1,
    'name': 'Habit 1',
    'repeat': '4',
    'days': [2, 3, 2],
    'notify': true,
    'type': {
      'icon': 'ic-close',
      'color': 'primary',
    },
  };

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: loaded, habits: habits)] when HabitLoadEvent is added and FetchHabitsUsecase returns success',
    build: () {
      when(() => fetchHabitsUsecase())
          .thenAnswer((_) async => Result.success(habits));
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    act: (bloc) => bloc.add(HabitLoadEvent()),
    expect: () => [
      HabitState(status: HabitStatus.loading),
      HabitState(
        habits: habits,
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: error, error: error.message)] when HabitLoadEvent is added and FetchHabitsUsecase returns failure',
    build: () {
      when(() => fetchHabitsUsecase()).thenAnswer(
        (_) async => Result.failure(const Failure(message: 'Error message')),
      );
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    act: (bloc) => bloc.add(HabitLoadEvent()),
    expect: () => [
      HabitState(status: HabitStatus.loading),
      HabitState(
        status: HabitStatus.error,
        error: 'Error message',
        updateIndex: -1,
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: loaded, habits: [...state.habits, habit])] when HabitAddEvent is added and SaveHabitUsecase returns success',
    build: () {
      when(() => saveHabitsUsecase(data: habit1d))
          .thenAnswer((_) async => Result.success(habit1));
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habit2]),
    act: (bloc) => bloc.add(HabitAddEvent(habit1d)),
    expect: () => [
      HabitState(
        habits: [habit2, habit1],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: toastError, error: error.message)] when HabitAddEvent is added and SaveHabitUsecase returns failure',
    build: () {
      when(() => saveHabitsUsecase(data: habit1d)).thenAnswer(
        (_) async => Result.failure(const Failure(message: 'Error message')),
      );
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habit2]),
    act: (bloc) => bloc.add(HabitAddEvent(habit1d)),
    expect: () => [
      HabitState(
        status: HabitStatus.toastError,
        error: 'Error message',
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: loaded, habits: [...state.habits], updateIndex: habit.id)] when HabitUpdateEvent is added and SaveHabitUsecase returns success',
    build: () {
      when(() => saveHabitsUsecase(data: habit1d))
          .thenAnswer((_) async => Result.success(habit1));
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habit1, habit2]),
    act: (bloc) => bloc.add(HabitUpdateEvent(habit1d)),
    expect: () => [
      HabitState(
        habits: [habit1, habit2],
        status: HabitStatus.loaded,
        updateIndex: habit1.id ?? 0,
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: toastError, error: error.message)] when HabitUpdateEvent is added and SaveHabitUsecase returns failure',
    build: () {
      when(() => saveHabitsUsecase(data: habit1d)).thenAnswer(
        (_) async => Result.failure(const Failure(message: 'Error message')),
      );
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habit1, habit2]),
    act: (bloc) => bloc.add(HabitUpdateEvent(habit1d)),
    expect: () => [
      HabitState(
        status: HabitStatus.toastError,
        error: 'Error message',
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: loaded, habits: list, updateIndex: -1)] when HabitDeleteEvent is added and DeleteHabitUsecase returns success',
    build: () {
      when(() => deleteHabitsUsecase(habit: habit1))
          .thenAnswer((_) async => Result.success(habit1));
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habit1, habit2]),
    act: (bloc) => bloc.add(HabitDeleteEvent(habit1)),
    expect: () => [
      HabitState(
        habits: [habit2],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: toastError, error: error.message)] when HabitDeleteEvent is added and DeleteHabitUsecase returns failure',
    build: () {
      when(() => deleteHabitsUsecase(habit: habit1)).thenAnswer(
        (_) async => Result.failure(const Failure(message: 'Error message')),
      );
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habit1, habit2]),
    act: (bloc) => bloc.add(HabitDeleteEvent(habit1)),
    expect: () => [
      HabitState(
        status: HabitStatus.toastError,
        error: 'Error message',
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: loaded, habits: [...state.habits], updateIndex: habit.id)] when HabitResetEvent is added and ResetHabitProgressUsecase returns success',
    build: () {
      when(() => resetHabitUsecase(habit: habit1, index: 0))
          .thenAnswer((_) async => Result.success(habit1));
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habit1, habit2]),
    act: (bloc) => bloc.add(HabitResetEvent(habit: habit1, index: 0)),
    expect: () => [
      HabitState(
        habits: [habit1, habit2],
        status: HabitStatus.loaded,
        updateIndex: habit1.id ?? 0,
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: toastError, error: error.message)] when HabitResetEvent is added and ResetHabitProgressUsecase returns failure',
    build: () {
      when(() => resetHabitUsecase(habit: habit1, index: 0)).thenAnswer(
        (_) async => Result.failure(const Failure(message: 'Error message')),
      );
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habit1, habit2]),
    act: (bloc) => bloc.add(HabitResetEvent(habit: habit1, index: 0)),
    expect: () => [
      HabitState(
        status: HabitStatus.toastError,
        error: 'Error message',
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: loaded, updateIndex: -1)] when HabitProgressEvent is added and AddHabitProgressUsecase returns success',
    build: () {
      when(() => addHabitProgressUsecase(habit: habit1, dayIndex: 0))
          .thenAnswer((_) async => Result.success(habit1));
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habit1, habit2]),
    act: (bloc) => bloc.add(HabitProgressEvent(habit: habit1, index: 0)),
    expect: () => [],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - HabitState(status: toastError, error: error.message)] when HabitProgressEvent is added and AddHabitProgressUsecase returns failure',
    build: () {
      when(() => addHabitProgressUsecase(habit: habit1, dayIndex: 0))
          .thenAnswer(
        (_) async => Result.failure(const Failure(message: 'Error message')),
      );
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habit1, habit2]),
    act: (bloc) => bloc.add(HabitProgressEvent(habit: habit1, index: 0)),
    expect: () => [
      HabitState(
        status: HabitStatus.toastError,
        error: 'Error message',
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - emits loading and loads habits when clear habit progress is successful',
    build: () {
      when(() => fetchHabitsUsecase())
          .thenAnswer((_) async => Result.success(habits));
      when(() => clearHabitProgressUsecase())
          .thenAnswer((_) async => Result.success(true));
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habitEntity]),
    act: (bloc) => bloc.add(HabitClearEvent()),
    expect: () => [
      HabitState(
        habits: habits,
        status: HabitStatus.loaded,
      ),
    ],
  );

  blocTest<HabitsBloc, HabitState>(
    'habits/presentation/state - emits error when clear habit progress fails',
    build: () {
      when(() => clearHabitProgressUsecase()).thenAnswer(
        (_) async => Result.failure(
          const Failure(message: 'Error clearing habit progress'),
        ),
      );
      return HabitsBloc(
        fetchHabitsUsecase: fetchHabitsUsecase,
        deleteHabitsUsecase: deleteHabitsUsecase,
        saveHabitsUsecase: saveHabitsUsecase,
        resetHabitUsecase: resetHabitUsecase,
        addHabitProgressUsecase: addHabitProgressUsecase,
        clearHabitProgress: clearHabitProgressUsecase,
      );
    },
    seed: () => HabitState(habits: [habitEntity]),
    act: (bloc) => bloc.add(HabitClearEvent()),
    expect: () => [
      HabitState(
        status: HabitStatus.error,
        error: 'Error clearing habit progress',
        updateIndex: -1,
      ),
    ],
  );
}
