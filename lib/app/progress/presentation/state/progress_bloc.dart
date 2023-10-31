import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/progress/domain/usecases/get_progress_usecase.dart';
import 'package:habit_go/app/progress/domain/usecases/reset_progress_usecase.dart';
import 'package:habit_go/app/progress/domain/usecases/update_actions_done_usecase.dart';
import 'package:habit_go/app/progress/domain/usecases/update_total_actions_usecase.dart';
import 'package:habit_go/app/progress/presentation/state/progress_event.dart';
import 'package:habit_go/app/progress/presentation/state/progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final GetProgressUsecase _getProgress;
  final ResetProgressUsecase _resetProgress;
  final UpdateActionsDoneUsecase _updateActionsDone;
  final UpdateTotalActionsUsecase _updateTotalActions;

  ProgressBloc({
    required GetProgressUsecase getProgressUsecase,
    required ResetProgressUsecase resetProgressUsecase,
    required UpdateActionsDoneUsecase updateActionsDoneUsecase,
    required UpdateTotalActionsUsecase updateTotalActionsUsecase,
  })  : _getProgress = getProgressUsecase,
        _resetProgress = resetProgressUsecase,
        _updateActionsDone = updateActionsDoneUsecase,
        _updateTotalActions = updateTotalActionsUsecase,
        super(ProgressState()) {
    on<ProgressLoadEvent>(_onLoad);
    on<ProgressActionEvent>(_onAction, transformer: sequential());
    on<ProgressUpdateEvent>(_onUpdate);
    on<ProgressResetEvent>(_onReset);
  }

  FutureOr<void> _onLoad(
    ProgressLoadEvent event,
    Emitter<ProgressState> emit,
  ) async {
    emit(state.copyWith(status: ProgressStatus.loading));

    final result = await _getProgress();
    result.when(
      success: (progress) {
        emit(
          state.copyWith(
            progress: progress,
            status: ProgressStatus.loaded,
          ),
        );
      },
      failure: (error) {
        emit(
          ProgressState(
            status: ProgressStatus.error,
            error: error.message,
          ),
        );
      },
    );
  }

  FutureOr<void> _onAction(
    ProgressActionEvent event,
    Emitter<ProgressState> emit,
  ) async {
    final index = event.index;
    final value = event.value;

    final result = await _updateActionsDone(
      day: index,
      actions: value,
      delete: event.delete,
    );

    result.when(
      success: (progress) {
        emit(
          state.copyWith(
            progress: progress,
            status: ProgressStatus.loaded,
          ),
        );
      },
      failure: (error) {
        emit(
          ProgressState(
            status: ProgressStatus.error,
            error: error.message,
          ),
        );
      },
    );
  }

  FutureOr<void> _onUpdate(
    ProgressUpdateEvent event,
    Emitter<ProgressState> emit,
  ) async {
    final result = await _updateTotalActions(
      actionDays: event.progress,
      repeat: event.repeat,
      oldActionDays: event.oldProgress,
      oldRepeat: event.oldRepeat,
      delete: event.delete,
    );

    result.when(
      success: (progress) {
        emit(
          state.copyWith(
            progress: progress,
            status: ProgressStatus.loaded,
          ),
        );
      },
      failure: (error) {
        emit(
          ProgressState(
            status: ProgressStatus.error,
            error: error.message,
          ),
        );
      },
    );
  }

  FutureOr<void> _onReset(
    ProgressResetEvent event,
    Emitter<ProgressState> emit,
  ) async {
    final result = await _resetProgress();

    result.when(
      success: (progress) {
        emit(
          state.copyWith(
            progress: progress,
            status: ProgressStatus.loaded,
          ),
        );
      },
      failure: (error) {
        emit(
          ProgressState(
            status: ProgressStatus.error,
            error: error.message,
          ),
        );
      },
    );
  }
}
