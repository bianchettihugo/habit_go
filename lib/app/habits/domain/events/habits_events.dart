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
