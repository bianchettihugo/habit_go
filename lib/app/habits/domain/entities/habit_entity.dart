import 'package:flutter/foundation.dart';

class HabitEntity {
  final int? id;
  final String title;
  final String icon;
  final String color;
  final int repeat;
  final List<int> progress;
  final bool reminder;

  HabitEntity({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.repeat,
    required this.progress,
    required this.reminder,
  });

  @override
  bool operator ==(covariant HabitEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.icon == icon &&
        other.color == color &&
        other.repeat == repeat &&
        listEquals(other.progress, progress) &&
        other.reminder == reminder;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        icon.hashCode ^
        color.hashCode ^
        repeat.hashCode ^
        reminder.hashCode;
  }

  HabitEntity copyWith({
    int? id,
    String? title,
    String? icon,
    String? color,
    int? repeat,
    List<int>? progress,
    bool? reminder,
  }) {
    return HabitEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      repeat: repeat ?? this.repeat,
      progress: progress ?? this.progress,
      reminder: reminder ?? this.reminder,
    );
  }
}
