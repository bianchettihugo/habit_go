class ProgressEntity {
  final int id = 0;
  final List<int> doneActions;
  final List<int> totalActions;

  ProgressEntity({
    this.doneActions = const [],
    this.totalActions = const [],
  });
}
