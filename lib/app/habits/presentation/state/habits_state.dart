import 'package:flutter/foundation.dart';

import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';

enum HabitStatus {
  loading,
  loaded,
  error,
  toastError,
}

class HabitState {
  final List<HabitEntity> habits;
  final HabitStatus status;
  final String error;
  final int updateIndex;

  HabitState({
    this.habits = const [],
    this.status = HabitStatus.loading,
    this.error = '',
    this.updateIndex = -1,
  });

  @override
  bool operator ==(covariant HabitState other) {
    if (identical(this, other)) return true;

    return listEquals(other.habits, habits) &&
        other.status == status &&
        other.error == error &&
        other.updateIndex == updateIndex;
  }

  @override
  int get hashCode {
    return status.hashCode ^ error.hashCode ^ updateIndex.hashCode;
  }

  HabitState copyWith({
    List<HabitEntity>? habits,
    HabitStatus? status,
    String? error,
    int? updateIndex,
  }) {
    return HabitState(
      habits: habits ?? this.habits,
      status: status ?? this.status,
      error: error ?? this.error,
      updateIndex: updateIndex ?? this.updateIndex,
    );
  }
}
