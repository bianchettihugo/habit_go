import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/domain/repositories/reminder_repository.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class SetHabitRemindersUsecase {
  Future<Result<List<ReminderEntity>>> call({
    required int habitId,
    required List<ReminderEntity> reminders,
  });
}

class SetHabitRemindersUsecaseImpl extends SetHabitRemindersUsecase {
  final ReminderRepository _repository;

  SetHabitRemindersUsecaseImpl({required ReminderRepository repository})
      : _repository = repository;

  @override
  Future<Result<List<ReminderEntity>>> call({
    required int habitId,
    required List<ReminderEntity> reminders,
  }) async {
    return _repository.setHabitReminders(
      habitId: habitId,
      reminders: reminders,
    );
  }
}
