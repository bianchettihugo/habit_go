import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/reminders/domain/usecases/add_reminder_usecase.dart';
import 'package:habit_go/app/reminders/domain/usecases/delete_reminder_usecase.dart';
import 'package:habit_go/app/reminders/domain/usecases/fetch_reminders_usecase.dart';
import 'package:habit_go/app/reminders/domain/usecases/set_habit_reminders_usecase.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_events.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_state.dart';

class RemindersBloc extends Bloc<ReminderEvent, ReminderState> {
  final FetchRemindersUsecase _fetchReminders;
  final DeleteReminderUsecase _deleteReminder;
  final AddReminderUsecase _addReminder;
  final SetHabitRemindersUsecase _setHabitReminders;

  RemindersBloc({
    required FetchRemindersUsecase fetchRemindersUsecase,
    required DeleteReminderUsecase deleteReminderUsecase,
    required AddReminderUsecase addReminderUsecase,
    required SetHabitRemindersUsecase setHabitRemindersUsecase,
  })  : _fetchReminders = fetchRemindersUsecase,
        _deleteReminder = deleteReminderUsecase,
        _addReminder = addReminderUsecase,
        _setHabitReminders = setHabitRemindersUsecase,
        super(ReminderState()) {
    on<ReminderLoadEvent>(_onLoad);
    on<ReminderAddEvent>(_onAdd);
    on<ReminderDeleteEvent>(_onDelete);
    on<ReminderSetEvent>(_onReminderSet);
  }

  Future<void> _onLoad(
    ReminderLoadEvent event,
    Emitter<ReminderState> emit,
  ) async {
    emit(state.copyWith(status: ReminderStatus.loading));

    final result = await _fetchReminders();
    result.when(
      success: (reminders) {
        emit(
          state.copyWith(
            reminders: reminders,
            status: ReminderStatus.loaded,
          ),
        );
      },
      failure: (error) {
        emit(
          ReminderState(
            status: ReminderStatus.error,
            error: error.message,
          ),
        );
      },
    );
  }

  Future<void> _onAdd(
    ReminderAddEvent event,
    Emitter<ReminderState> emit,
  ) async {
    emit(state.copyWith(status: ReminderStatus.loading));

    final result = await _addReminder(event.reminder);
    result.when(
      success: (reminder) {
        emit(
          state.copyWith(
            reminders: [...state.reminders, reminder],
            status: ReminderStatus.loaded,
          ),
        );
      },
      failure: (error) {
        emit(
          ReminderState(
            status: ReminderStatus.toastError,
            error: error.message,
          ),
        );
      },
    );
  }

  Future<void> _onDelete(
    ReminderDeleteEvent event,
    Emitter<ReminderState> emit,
  ) async {
    emit(state.copyWith(status: ReminderStatus.loading));

    final result = await _deleteReminder(event.reminder);
    result.when(
      success: (reminder) {
        final list = state.reminders.where((e) => e.id != reminder.id).toList();
        emit(
          state.copyWith(
            reminders: list,
            status: ReminderStatus.loaded,
          ),
        );
      },
      failure: (error) {
        emit(
          ReminderState(
            status: ReminderStatus.toastError,
            error: error.message,
          ),
        );
      },
    );
  }

  Future<void> _onReminderSet(
    ReminderSetEvent event,
    Emitter<ReminderState> emit,
  ) async {
    emit(state.copyWith(status: ReminderStatus.loading));

    final result = await _setHabitReminders(
      habitId: event.habitId,
      reminders: event.reminders,
    );
    result.when(
      success: (_) {
        emit(
          state.copyWith(
            reminders: event.reminders,
            status: ReminderStatus.loaded,
          ),
        );
      },
      failure: (error) {
        emit(
          ReminderState(
            status: ReminderStatus.toastError,
            error: error.message,
          ),
        );
      },
    );
  }
}
