import 'package:flutter/foundation.dart';
import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:isar/isar.dart';

part 'progress_model.g.dart';

@collection
class ProgressModel {
  Id id = 0;
  List<short> doneActions;
  List<short> totalActions;

  ProgressModel({
    this.id = 0,
    this.doneActions = const [],
    this.totalActions = const [],
  });

  factory ProgressModel.fromEntity(ProgressEntity entity) {
    return ProgressModel(
      doneActions: entity.doneActions,
      totalActions: entity.totalActions,
    );
  }

  ProgressEntity toEntity() {
    return ProgressEntity(
      doneActions: doneActions,
      totalActions: totalActions,
    );
  }

  @override
  bool operator ==(covariant ProgressModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.doneActions, doneActions) &&
        listEquals(other.totalActions, totalActions);
  }

  @override
  int get hashCode => id.hashCode;
}
