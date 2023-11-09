import 'package:flutter/foundation.dart';
import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:isar/isar.dart';

part 'reminder_model.g.dart';

@collection
class ReminderModel {
  Id? id;
  short? habitId;
  String title;
  DateTime? time;
  bool enabled;
  List<byte> days;

  ReminderModel({
    Id? id,
    this.title = '',
    this.habitId,
    this.time,
    this.enabled = true,
    this.days = const [],
  }) : id = id ?? Isar.autoIncrement;

  factory ReminderModel.fromEntity(ReminderEntity entity) {
    return ReminderModel(
      id: entity.id,
      habitId: entity.habitId,
      title: entity.title,
      time: entity.time,
      enabled: entity.enabled,
      days: entity.days,
    );
  }

  ReminderEntity toEntity() {
    return ReminderEntity(
      id: id ?? 0,
      title: title,
      habitId: habitId,
      time: time ?? DateTime.now(),
      enabled: enabled,
      days: days,
    );
  }

  @override
  bool operator ==(covariant ReminderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.time == time &&
        other.habitId == habitId &&
        listEquals(days, other.days) &&
        other.enabled == enabled;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ enabled.hashCode ^ habitId.hashCode;
  }
}
