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

  const ProgressActionEvent({
    required this.index,
    this.value = 1,
  });

  @override
  List<Object?> get props => [index, value];
}

class ProgressUpdateEvent extends ProgressEvent {
  final List<int> progress;
  final int repeat;
  final List<int>? oldProgress;
  final int? oldRepeat;

  const ProgressUpdateEvent({
    required this.progress,
    required this.repeat,
    this.oldProgress,
    this.oldRepeat,
  });

  @override
  List<Object?> get props => [
        progress,
        repeat,
        oldProgress,
        oldRepeat,
      ];
}

class ProgressResetEvent extends ProgressEvent {
  const ProgressResetEvent();
}
