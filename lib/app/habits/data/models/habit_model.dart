import 'package:flutter/foundation.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:isar/isar.dart';

part 'habit_model.g.dart';

@collection
class HabitModel {
  Id? id;
  String title;
  String icon;
  String color;
  int repeat;
  List<byte> originalProgress;
  List<byte> progress;
  bool reminder;

  HabitModel({
    Id? id,
    this.title = '',
    this.icon = '',
    this.color = '',
    this.repeat = 1,
    this.originalProgress = const [],
    this.progress = const [],
    this.reminder = false,
  }) : id = id ?? Isar.autoIncrement;

  factory HabitModel.fromEntity(HabitEntity entity) {
    return HabitModel(
      id: entity.id,
      title: entity.title,
      icon: entity.icon,
      color: entity.color,
      repeat: entity.repeat,
      originalProgress: entity.originalProgress,
      progress: entity.progress,
      reminder: entity.reminder,
    );
  }

  HabitEntity toEntity() {
    return HabitEntity(
      id: id,
      title: title,
      icon: icon,
      color: color,
      repeat: repeat,
      originalProgress: originalProgress,
      progress: progress,
      reminder: reminder,
    );
  }

  @override
  bool operator ==(covariant HabitModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.icon == icon &&
        other.color == color &&
        other.repeat == repeat &&
        listEquals(other.originalProgress, originalProgress) &&
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

  HabitModel copyWith({
    Id? id,
    String? title,
    String? icon,
    String? color,
    int? repeat,
    List<byte>? originalProgress,
    List<byte>? progress,
    bool? reminder,
  }) {
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      repeat: repeat ?? this.repeat,
      originalProgress: originalProgress ?? this.originalProgress,
      progress: progress ?? this.progress,
      reminder: reminder ?? this.reminder,
    );
  }
}
