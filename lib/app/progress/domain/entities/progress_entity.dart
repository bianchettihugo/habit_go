import 'package:flutter/foundation.dart';

class ProgressEntity {
  final int id = 0;
  final List<int> doneActions;
  final List<int> totalActions;

  ProgressEntity({
    this.doneActions = const [],
    this.totalActions = const [],
  });

  @override
  bool operator ==(covariant ProgressEntity other) {
    if (identical(this, other)) return true;

    return listEquals(other.doneActions, doneActions) &&
        listEquals(other.totalActions, totalActions);
  }

  @override
  int get hashCode => id.hashCode;

  ProgressEntity copyWith({
    List<int>? doneActions,
    List<int>? totalActions,
  }) {
    return ProgressEntity(
      doneActions: doneActions ?? this.doneActions,
      totalActions: totalActions ?? this.totalActions,
    );
  }
}
