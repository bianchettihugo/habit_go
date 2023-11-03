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
  Future<List<ReminderModel>> getReminders() async {
    var items = <ReminderModel>[];
    await _isar.txn(() async {
      items = await _isar.reminderModels.where().findAll();
    });
    return items;
  }
}
