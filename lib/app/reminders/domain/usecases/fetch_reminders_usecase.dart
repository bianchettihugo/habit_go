import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/domain/repositories/reminder_repository.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class FetchRemindersUsecase {
  Future<Result<List<ReminderEntity>>> call();
}

class FetchRemindersUsecaseImpl extends FetchRemindersUsecase {
  final ReminderRepository _repository;

  FetchRemindersUsecaseImpl({required ReminderRepository repository})
      : _repository = repository;

  @override
  Future<Result<List<ReminderEntity>>> call() async {
    return _repository.getReminders();
  }
}
