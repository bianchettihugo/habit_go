import 'package:equatable/equatable.dart';

import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';

sealed class ReminderEvent extends Equatable {}

class ReminderLoadEvent extends ReminderEvent {
  @override
  List<Object?> get props => [];
}

class ReminderAddEvent extends ReminderEvent {
  final ReminderEntity reminder;

  ReminderAddEvent(this.reminder);

  @override
  List<Object?> get props => [reminder];
}

class ReminderDeleteEvent extends ReminderEvent {
  final ReminderEntity reminder;

  ReminderDeleteEvent(this.reminder);

  @override
  List<Object?> get props => [reminder];
}
