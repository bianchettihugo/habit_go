import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';

sealed class HabitEvent {}

class HabitLoadEvent extends HabitEvent {}

class HabitAddEvent extends HabitEvent {
  final Map<String, dynamic> data;

  HabitAddEvent(this.data);
}

class HabitUpdateEvent extends HabitEvent {
  final Map<String, dynamic> data;

  HabitUpdateEvent(this.data);
}

class HabitDeleteEvent extends HabitEvent {
  final HabitEntity habit;

  HabitDeleteEvent(this.habit);
}

class HabitProgressEvent extends HabitEvent {
  final int index;
  final HabitEntity habit;

  HabitProgressEvent({
    required this.habit,
    required this.index,
  });
}

class HabitResetEvent extends HabitEvent {
  final int index;
  final HabitEntity habit;

  HabitResetEvent({
    required this.habit,
    required this.index,
  });
}
