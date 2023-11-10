import 'package:flutter/foundation.dart';

enum HabitFormStatus {
  loading,
  success,
  error,
}

class HabitFormState {
  final HabitFormStatus status;
  final List<DateTime> reminders;
  final String? error;

  HabitFormState({
    this.status = HabitFormStatus.success,
    this.reminders = const [],
    this.error,
  });

  HabitFormState copyWith({
    HabitFormStatus? status,
    List<DateTime>? reminders,
    String? error,
  }) {
    return HabitFormState(
      status: status ?? this.status,
      reminders: reminders ?? this.reminders,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(covariant HabitFormState other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        listEquals(other.reminders, reminders) &&
        other.error == error;
  }

  @override
  int get hashCode => status.hashCode ^ error.hashCode;
}
