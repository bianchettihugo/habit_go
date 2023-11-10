import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/domain/repositories/reminder_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class FetchRemindersByHabitIdUsecase {
  Future<Result<List<ReminderEntity>>> call(int id);
}

class FetchRemindersByHabitIdUsecaseImpl
    extends FetchRemindersByHabitIdUsecase {
  final ReminderRepository _repository;

  FetchRemindersByHabitIdUsecaseImpl({required ReminderRepository repository})
      : _repository = repository;

  @override
  Future<Result<List<ReminderEntity>>> call(int id) async {
    if (id < 0) {
      return Result.failure(const InvalidDataFailure());
    }

    return _repository.getReminders(id);
  }
}
