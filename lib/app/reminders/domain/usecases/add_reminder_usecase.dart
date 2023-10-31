import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/domain/repositories/reminder_repository.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class AddReminderUsecase {
  Future<Result<ReminderEntity>> call(ReminderEntity reminder);
}

class AddReminderUsecaseImpl extends AddReminderUsecase {
  final ReminderRepository _repository;

  AddReminderUsecaseImpl({required ReminderRepository repository})
      : _repository = repository;

  @override
  Future<Result<ReminderEntity>> call(ReminderEntity reminder) async {
    return _repository.addReminder(reminder);
  }
}
