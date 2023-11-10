import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habit_reminders_usecase.dart';
import 'package:habit_go/app/habits/presentation/state/habits_form_state.dart';

class HabitFormCubit extends Cubit<HabitFormState> {
  final FetchHabitReminderUsecase _fetchHabitReminders;

  HabitFormCubit({required FetchHabitReminderUsecase fetchHabitReminders})
      : _fetchHabitReminders = fetchHabitReminders,
        super(HabitFormState());

  Future<void> fetchHabitReminders({required int habitId}) async {
    emit(state.copyWith(status: HabitFormStatus.loading));
    final reminders = await _fetchHabitReminders(habitId: habitId);
    reminders.when(
      success: (reminders) => emit(
        state.copyWith(
          status: HabitFormStatus.success,
          reminders: reminders,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          status: HabitFormStatus.error,
          error: error.toString(),
          reminders: [],
        ),
      ),
    );
  }

  void addReminder(DateTime reminder) {
    final reminders = [...state.reminders, reminder];
    emit(state.copyWith(reminders: reminders));
  }

  void removeReminder(DateTime reminder) {
    final reminders = [...state.reminders];
    reminders.remove(reminder);
    emit(state.copyWith(reminders: reminders));
  }

  void clearReminders() {
    emit(state.copyWith(reminders: []));
  }
}
