import 'package:flutter/foundation.dart';

class ReminderEntity {
  final int id;
  final int? habitId;
  final DateTime time;
  final String title;
  final bool enabled;
  final List<int> days;

  const ReminderEntity({
    required this.time,
    required this.title,
    this.habitId,
    this.id = 0,
    this.enabled = true,
    this.days = const [],
  });

  @override
  bool operator ==(covariant ReminderEntity other) {
    if (identical(this, other)) return true;

    return other.time == time &&
        other.title == title &&
        other.habitId == habitId &&
        other.enabled == enabled &&
        listEquals(days, other.days) &&
        other.id == id;
  }

  @override
  int get hashCode =>
      title.hashCode ^ enabled.hashCode ^ id.hashCode ^ habitId.hashCode;

  ReminderEntity copyWith({
    int? id,
    DateTime? time,
    String? title,
    bool? enabled,
    List<int>? days,
  }) {
    return ReminderEntity(
      time: time ?? this.time,
      title: title ?? this.title,
      enabled: enabled ?? this.enabled,
      id: id ?? this.id,
      days: days ?? this.days,
    );
  }
}
