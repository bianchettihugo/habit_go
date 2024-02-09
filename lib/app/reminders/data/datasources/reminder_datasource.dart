import 'package:habit_go/app/reminders/data/models/reminder_model.dart';

abstract class ReminderDatasource {
  Future<List<ReminderModel>> getReminders([int? habitId]);
  Future<ReminderModel> addReminder(ReminderModel reminder);
  Future<List<ReminderModel>> setHabitReminders({
    required int habitId,
    required List<ReminderModel> reminders,
  });
  Future<ReminderModel> deleteReminder(ReminderModel reminder);
}
