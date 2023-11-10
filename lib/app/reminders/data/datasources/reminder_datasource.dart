import 'package:habit_go/app/reminders/data/models/reminder_model.dart';

abstract class ReminderDatasource {
  Future<List<ReminderModel>> getReminders([int? habitId]);
  Future<ReminderModel> addReminder(ReminderModel reminder);
  Future<ReminderModel> deleteReminder(ReminderModel reminder);
}
