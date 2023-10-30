import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';

enum ProgressStatus {
  loading,
  loaded,
  error,
}

class ProgressState {
  final ProgressEntity progress;
  final ProgressStatus status;
  final String error;

  ProgressState({
    this.progress = const ProgressEntity(),
    this.status = ProgressStatus.loading,
    this.error = '',
  });

  ProgressState copyWith({
    ProgressEntity? progress,
    ProgressStatus? status,
    String? error,
  }) {
    return ProgressState(
      progress: progress ?? this.progress,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  bool operator ==(covariant ProgressState other) {
    if (identical(this, other)) return true;

    return other.progress == progress &&
        other.status == status &&
        other.error == error;
  }

  @override
  int get hashCode => progress.hashCode ^ status.hashCode ^ error.hashCode;
}
