import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/domain/repositories/reminder_repository.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class DeleteReminderUsecase {
  Future<Result<ReminderEntity>> call(ReminderEntity reminder);
}

class DeleteReminderUsecaseImpl extends DeleteReminderUsecase {
  final ReminderRepository _repository;

  DeleteReminderUsecaseImpl({required ReminderRepository repository})
      : _repository = repository;

  @override
  Future<Result<ReminderEntity>> call(ReminderEntity reminder) async {
    return _repository.deleteReminder(reminder);
  }
}
