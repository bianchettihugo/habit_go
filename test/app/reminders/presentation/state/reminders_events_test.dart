import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_events.dart';

import '../../../../utils/data.dart';

void main() {
  test(
      'reminder/presentation/state - ReminderLoadEvent should have empty props',
      () {
    final event = ReminderLoadEvent();
    expect(event.props, []);
  });

  test(
      'reminder/presentation/state - ReminderAddEvent should have reminder in props',
      () {
    final reminder = reminderEntity;
    final event = ReminderAddEvent(reminder);
    expect(event.props, [reminder]);
  });

  test(
      'reminder/presentation/state - ReminderDeleteEvent should have reminder in props',
      () {
    final reminder = reminderEntity;
    final event = ReminderDeleteEvent(reminder);
    expect(event.props, [reminder]);
  });
}
