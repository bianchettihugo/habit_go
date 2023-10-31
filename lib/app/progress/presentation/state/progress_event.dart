import 'package:equatable/equatable.dart';

sealed class ProgressEvent extends Equatable {
  const ProgressEvent();

  @override
  List<Object?> get props => [];
}

class ProgressLoadEvent extends ProgressEvent {
  const ProgressLoadEvent();
}

class ProgressActionEvent extends ProgressEvent {
  final int index;
  final int value;
  final bool delete;

  const ProgressActionEvent({
    required this.index,
    this.value = 1,
    this.delete = false,
  });

  @override
  List<Object?> get props => [index, value, delete];
}

class ProgressUpdateEvent extends ProgressEvent {
  final List<int> progress;
  final int repeat;
  final List<int>? oldProgress;
  final int? oldRepeat;
  final bool delete;

  const ProgressUpdateEvent({
    required this.progress,
    required this.repeat,
    this.oldProgress,
    this.oldRepeat,
    this.delete = false,
  });

  @override
  List<Object?> get props => [
        progress,
        repeat,
        oldProgress,
        oldRepeat,
        delete,
      ];
}

class ProgressResetEvent extends ProgressEvent {
  const ProgressResetEvent();
}
