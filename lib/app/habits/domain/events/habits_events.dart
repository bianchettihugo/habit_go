import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/core/values/events.dart';

class HabitSavedEvent extends Event {
  final Map<String, dynamic> data;

  HabitSavedEvent({
    this.data = const {},
  });
}

class HabitDeleteEvent extends Event {
  final HabitEntity entity;

  HabitDeleteEvent({
    required this.entity,
  });
}

class HabitActionEvent extends Event {
  final int day;

  HabitActionEvent({
    required this.day,
  });
}

class HabitResetProgressEvent extends Event {
  final int progress;
  final int day;

  HabitResetProgressEvent({
    required this.progress,
    required this.day,
  });
}

class HabitRemindersRequestEvent extends Event {
  final int habitId;

  HabitRemindersRequestEvent({
    required this.habitId,
  });

  @override
  bool operator ==(covariant HabitRemindersRequestEvent other) {
    if (identical(this, other)) return true;

    return other.habitId == habitId;
  }

  @override
  int get hashCode => habitId.hashCode;
}

class HabitRemindersChangedEvent extends Event {
  final int habitId;
  final List<DateTime> reminders;
  final List<int> days;
  final String title;

  HabitRemindersChangedEvent({
    required this.habitId,
    required this.reminders,
    required this.days,
    required this.title,
  });
}
