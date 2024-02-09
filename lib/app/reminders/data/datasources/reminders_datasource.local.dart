import 'package:habit_go/app/reminders/data/datasources/reminder_datasource.dart';
import 'package:habit_go/app/reminders/data/models/reminder_model.dart';
import 'package:isar/isar.dart';

class LocalReminderDatasource extends ReminderDatasource {
  final Isar _isar;

  LocalReminderDatasource({
    required Isar isar,
  }) : _isar = isar;

  @override
  Future<ReminderModel> addReminder(ReminderModel reminder) async {
    await _isar.writeTxn(() async {
      return _isar.reminderModels.put(reminder);
    });

    return reminder;
  }

  @override
  Future<ReminderModel> deleteReminder(ReminderModel reminder) async {
    await _isar.writeTxn(() async {
      return _isar.reminderModels.delete(reminder.id ?? -1);
    });

    return reminder;
  }

  @override
  Future<List<ReminderModel>> getReminders([int? habitId]) async {
    var items = <ReminderModel>[];
    await _isar.txn(() async {
      items = habitId != null
          ? await _isar.reminderModels
              .filter()
              .habitIdEqualTo(habitId)
              .findAll()
          : await _isar.reminderModels.where().findAll();
    });
    return items;
  }

  @override
  Future<List<ReminderModel>> setHabitReminders({
    required int habitId,
    required List<ReminderModel> reminders,
  }) async {
    await _isar.writeTxn(() async {
      await _isar.reminderModels.filter().habitIdEqualTo(habitId).deleteAll();
      await _isar.reminderModels.putAll(reminders);
    });

    return getReminders();
  }
}
