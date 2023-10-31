import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class ReminderRepository {
  Future<Result<List<ReminderEntity>>> getReminders();
  Future<Result<ReminderEntity>> addReminder(ReminderEntity reminder);
  Future<Result<ReminderEntity>> deleteReminder(ReminderEntity reminder);
}
