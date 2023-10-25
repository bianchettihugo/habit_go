import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/habits/domain/usecases/add_habit_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habits_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/reset_habit_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/save_habit_usecase.dart';
import 'package:habit_go/app/habits/presentation/state/habits_event.dart';
import 'package:habit_go/app/habits/presentation/state/habits_state.dart';

class HabitsBloc extends Bloc<HabitEvent, HabitState> {
  final FetchHabitsUsecase _fetchHabits;
  final DeleteHabitUsecase _deleteHabits;
  final SaveHabitUsecase _saveHabits;
  final ResetHabitProgressUsecase _resetHabit;
  final AddHabitProgressUsecase _addHabitProgress;

  HabitsBloc({
    required FetchHabitsUsecase fetchHabitsUsecase,
    required DeleteHabitUsecase deleteHabitsUsecase,
    required SaveHabitUsecase saveHabitsUsecase,
    required ResetHabitProgressUsecase resetHabitUsecase,
    required AddHabitProgressUsecase addHabitProgressUsecase,
  })  : _fetchHabits = fetchHabitsUsecase,
        _deleteHabits = deleteHabitsUsecase,
        _saveHabits = saveHabitsUsecase,
        _resetHabit = resetHabitUsecase,
        _addHabitProgress = addHabitProgressUsecase,
        super(HabitState()) {
    on<HabitLoadEvent>(_onLoad);
    on<HabitAddEvent>(_onAdd);
    on<HabitUpdateEvent>(_onUpdate);
    on<HabitDeleteEvent>(_onDelete);
    on<HabitProgressEvent>(_onProgress, transformer: sequential());
    on<HabitResetEvent>(_onReset);
  }

  Future<void> _onLoad(HabitLoadEvent event, Emitter<HabitState> emit) async {
    emit(state.copyWith(status: HabitStatus.loading));

    final result = await _fetchHabits();
    result.when(
      success: (habits) {
        emit(
          state.copyWith(
            habits: habits,
            status: HabitStatus.loaded,
            updateIndex: -1,
          ),
        );
      },
      failure: (error) {
        emit(
          HabitState(
            status: HabitStatus.error,
            error: error.message,
            updateIndex: -1,
          ),
        );
      },
    );
  }

  Future<void> _onAdd(HabitAddEvent event, Emitter<HabitState> emit) async {
    emit(state.copyWith(status: HabitStatus.loading));

    final result = await _saveHabits(data: event.data);
    result.when(
      success: (habit) {
        emit(
          state.copyWith(
            habits: [...state.habits, habit],
            status: HabitStatus.loaded,
            updateIndex: -1,
          ),
        );
      },
      failure: (error) {
        emit(
          HabitState(
            status: HabitStatus.toastError,
            error: error.message,
          ),
        );
      },
    );
  }

  Future<void> _onUpdate(
    HabitUpdateEvent event,
    Emitter<HabitState> emit,
  ) async {
    emit(state.copyWith(status: HabitStatus.loading));

    final result = await _saveHabits(data: event.data);
    result.when(
      success: (habit) {
        emit(
          state.copyWith(
            habits: [...state.habits],
            status: HabitStatus.loaded,
            updateIndex: habit.id,
          ),
        );
      },
      failure: (error) {
        emit(
          HabitState(
            status: HabitStatus.toastError,
            error: error.message,
          ),
        );
      },
    );
  }

  Future<void> _onDelete(
    HabitDeleteEvent event,
    Emitter<HabitState> emit,
  ) async {
    emit(state.copyWith(status: HabitStatus.loading));

    final result = await _deleteHabits(habit: event.habit);
    result.when(
      success: (habit) {
        final list = state.habits.where((e) => e.id != habit.id).toList();
        emit(
          state.copyWith(
            habits: list,
            status: HabitStatus.loaded,
            updateIndex: -1,
          ),
        );
      },
      failure: (error) {
        emit(
          HabitState(
            status: HabitStatus.toastError,
            error: error.message,
          ),
        );
      },
    );
  }

  Future<void> _onReset(HabitResetEvent event, Emitter<HabitState> emit) async {
    emit(state.copyWith(status: HabitStatus.loading));

    final result = await _resetHabit(
      habit: event.habit,
      index: event.index,
    );
    result.when(
      success: (habit) {
        emit(
          state.copyWith(
            habits: [...state.habits],
            status: HabitStatus.loaded,
            updateIndex: habit.id,
          ),
        );
      },
      failure: (error) {
        emit(
          HabitState(
            status: HabitStatus.toastError,
            error: error.message,
          ),
        );
      },
    );
  }

  Future<void> _onProgress(
    HabitProgressEvent event,
    Emitter<HabitState> emit,
  ) async {
    unawaited(
      _addHabitProgress(
        habit: event.habit,
        dayIndex: event.index,
      ).then((value) {
        if (!value.isSuccess) {
          emit(
            HabitState(
              status: HabitStatus.toastError,
              error: value.error?.message ?? '',
            ),
          );
        }
      }),
    );
  }
}
