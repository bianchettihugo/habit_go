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

  ProgressModel copyWith({
    List<short>? doneActions,
    List<short>? totalActions,
  }) {
    return ProgressModel(
      doneActions: doneActions ?? this.doneActions,
      totalActions: totalActions ?? this.totalActions,
    );
  }
}
