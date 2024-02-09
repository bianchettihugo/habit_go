import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/data/datasources/reminder_datasource.dart';
import 'package:habit_go/app/reminders/data/datasources/reminders_datasource.local.dart';
import 'package:habit_go/app/reminders/data/models/reminder_model.dart';
import 'package:isar/isar.dart';

import '../../../../utils/data.dart';

void main() {
  late Isar isar;
  late ReminderDatasource datasource;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([ReminderModelSchema], directory: '');
    datasource = LocalReminderDatasource(isar: isar);
  });

  test('reminders/data/datasources - should create a reminder', () async {
    final result = await datasource.addReminder(reminderModel);
    final reminder = await datasource.getReminders();
    expect(result, reminderModel);
    expect(reminder[0], reminderModel);
  });

  test('reminders/data/datasources - should get all reminders', () async {
    await datasource.addReminder(reminderModel);
    final result = await datasource.getReminders();
    expect(result, [reminderModel]);
  });

  test('reminders/data/datasources - should delete a reminder', () async {
    await datasource.addReminder(reminderModel);
    await datasource.deleteReminder(reminderModel);
    final result = await datasource.getReminders();
    expect(result, []);
  });

  test('reminders/data/datasources - should get reminders by habit id',
      () async {
    const habitId = 1;
    final date = DateTime.now();
    final reminder1 = ReminderModel(
      id: 1,
      habitId: habitId,
      title: 'Reminder 1',
      time: date,
    );
    final reminder2 = ReminderModel(
      id: 2,
      habitId: 2,
      title: 'Reminder 2',
      time: date,
    );
    await datasource.addReminder(reminder1);
    await datasource.addReminder(reminder2);
    final result = await datasource.getReminders(habitId);
    expect(result, [reminder1]);
  });

  tearDownAll(() {
    isar.close(deleteFromDisk: true);
  });
}
