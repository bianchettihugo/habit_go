import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';

part 'habit_model.g.dart';

@collection
class HabitModel {
  Id? id;
  String title;
  String icon;
  String color;
  int repeat;
  List<byte> progress;
  bool reminder;

  HabitModel({
    Id? id,
    this.title = '',
    this.icon = '',
    this.color = '',
    this.repeat = 1,
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
}
