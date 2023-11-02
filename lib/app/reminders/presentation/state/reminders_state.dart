import 'package:flutter/foundation.dart';

import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';

enum ReminderStatus {
  loading,
  loaded,
  error,
  toastError,
}

class ReminderState {
  final List<ReminderEntity> reminders;
  final ReminderStatus status;
  final String error;

  ReminderState({
    this.reminders = const [],
    this.status = ReminderStatus.loading,
    this.error = '',
  });

  @override
  bool operator ==(covariant ReminderState other) {
    if (identical(this, other)) return true;

    return listEquals(other.reminders, reminders) &&
        other.status == status &&
        other.error == error;
  }

  @override
  int get hashCode {
    return status.hashCode ^ error.hashCode;
  }

  ReminderState copyWith({
    List<ReminderEntity>? reminders,
    ReminderStatus? status,
    String? error,
  }) {
    return ReminderState(
      reminders: reminders ?? this.reminders,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
