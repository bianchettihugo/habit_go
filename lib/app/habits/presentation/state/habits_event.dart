import 'package:flutter/foundation.dart';

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

  @override
  bool operator ==(covariant HabitUpdateEvent other) {
    if (identical(this, other)) return true;

    return other.data['id'] == data['id'] &&
        other.data['name'] == data['name'] &&
        other.data['repeat'] == data['repeat'] &&
        other.data['notify'] == data['notify'] &&
        other.data['type']['icon'] == data['type']['icon'] &&
        other.data['type']['color'] == data['type']['color'] &&
        listEquals(other.data['days'], data['days']);
  }

  @override
  int get hashCode => data.hashCode;
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
