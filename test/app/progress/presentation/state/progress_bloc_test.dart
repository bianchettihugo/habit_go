// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/app/progress/presentation/state/progress_bloc.dart';
import 'package:habit_go/app/progress/presentation/state/progress_event.dart';
import 'package:habit_go/app/progress/presentation/state/progress_state.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late MockGetProgressUsecase mockGetProgressUsecase;
  late MockResetProgressUsecase mockResetProgressUsecase;
  late MockUpdateActionsDoneUsecase mockUpdateActionsDoneUsecase;
  late MockUpdateTotalActionsUsecase mockUpdateTotalActionsUsecase;

  setUp(() {
    mockGetProgressUsecase = MockGetProgressUsecase();
    mockResetProgressUsecase = MockResetProgressUsecase();
    mockUpdateActionsDoneUsecase = MockUpdateActionsDoneUsecase();
    mockUpdateTotalActionsUsecase = MockUpdateTotalActionsUsecase();
  });

  const progress = ProgressEntity(
    doneActions: [0, 1, 0],
    totalActions: [0, 0, 0],
  );

  blocTest<ProgressBloc, ProgressState>(
    'progress/presentation/state - emits [loading, loaded] when ProgressLoadEvent is added and usecase returns success',
    build: () {
      when(() => mockGetProgressUsecase()).thenAnswer(
        (_) => Future.value(Result.success(progress)),
      );
      return ProgressBloc(
        getProgressUsecase: mockGetProgressUsecase,
        resetProgressUsecase: mockResetProgressUsecase,
        updateActionsDoneUsecase: mockUpdateActionsDoneUsecase,
        updateTotalActionsUsecase: mockUpdateTotalActionsUsecase,
      );
    },
    act: (bloc) => bloc.add(const ProgressLoadEvent()),
    expect: () => [
      ProgressState(status: ProgressStatus.loading),
      ProgressState(
        progress: progress,
        status: ProgressStatus.loaded,
      ),
    ],
  );

  blocTest<ProgressBloc, ProgressState>(
    'progress/presentation/state - emits [loading, error] when ProgressLoadEvent is added and usecase returns failure',
    build: () {
      when(() => mockGetProgressUsecase()).thenAnswer(
        (_) => Future.value(
          Result.failure(const Failure(message: 'error message')),
        ),
      );
      return ProgressBloc(
        getProgressUsecase: mockGetProgressUsecase,
        resetProgressUsecase: mockResetProgressUsecase,
        updateActionsDoneUsecase: mockUpdateActionsDoneUsecase,
        updateTotalActionsUsecase: mockUpdateTotalActionsUsecase,
      );
    },
    act: (bloc) => bloc.add(const ProgressLoadEvent()),
    expect: () => [
      ProgressState(status: ProgressStatus.loading),
      ProgressState(
        status: ProgressStatus.error,
        error: 'error message',
      ),
    ],
  );

  blocTest<ProgressBloc, ProgressState>(
    'progress/presentation/state - emits [loaded] when ProgressActionEvent is added and usecase returns success',
    build: () {
      when(
        () => mockUpdateActionsDoneUsecase(
          day: any(named: 'day'),
          actions: any(named: 'actions'),
        ),
      ).thenAnswer(
        (_) => Future.value(
          Result.success(progress.copyWith(doneActions: [0, 2, 0])),
        ),
      );
      return ProgressBloc(
        getProgressUsecase: mockGetProgressUsecase,
        resetProgressUsecase: mockResetProgressUsecase,
        updateActionsDoneUsecase: mockUpdateActionsDoneUsecase,
        updateTotalActionsUsecase: mockUpdateTotalActionsUsecase,
      );
    },
    seed: () => ProgressState(progress: progress),
    act: (bloc) => bloc.add(const ProgressActionEvent(index: 1, value: 1)),
    expect: () => [
      ProgressState(
        progress: progress.copyWith(doneActions: [0, 2, 0]),
        status: ProgressStatus.loaded,
      ),
    ],
  );

  blocTest<ProgressBloc, ProgressState>(
    'progress/presentation/state - emits [error] when ProgressActionEvent is added and usecase returns failure',
    build: () {
      when(
        () => mockUpdateActionsDoneUsecase(
          day: any(named: 'day'),
          actions: any(named: 'actions'),
        ),
      ).thenAnswer(
        (_) => Future.value(
          Result.failure(const Failure(message: 'error message')),
        ),
      );
      return ProgressBloc(
        getProgressUsecase: mockGetProgressUsecase,
        resetProgressUsecase: mockResetProgressUsecase,
        updateActionsDoneUsecase: mockUpdateActionsDoneUsecase,
        updateTotalActionsUsecase: mockUpdateTotalActionsUsecase,
      );
    },
    seed: () => ProgressState(progress: progress),
    act: (bloc) => bloc.add(const ProgressActionEvent(index: 1, value: 1)),
    expect: () => [
      ProgressState(
        status: ProgressStatus.error,
        error: 'error message',
      ),
    ],
  );

  blocTest<ProgressBloc, ProgressState>(
    'progress/presentation/state - emits [loaded] when ProgressUpdateEvent is added and usecase returns success',
    build: () {
      when(
        () => mockUpdateTotalActionsUsecase(
          actionDays: any(named: 'actionDays'),
          repeat: any(named: 'repeat'),
          oldActionDays: any(named: 'oldActionDays'),
          oldRepeat: any(named: 'oldRepeat'),
          delete: any(named: 'delete'),
        ),
      ).thenAnswer(
        (_) => Future.value(Result.success(progress)),
      );
      return ProgressBloc(
        getProgressUsecase: mockGetProgressUsecase,
        resetProgressUsecase: mockResetProgressUsecase,
        updateActionsDoneUsecase: mockUpdateActionsDoneUsecase,
        updateTotalActionsUsecase: mockUpdateTotalActionsUsecase,
      );
    },
    seed: () => ProgressState(progress: progress),
    act: (bloc) => bloc.add(
      const ProgressUpdateEvent(
        progress: [0, 1, 0],
        repeat: 2,
        oldProgress: [0, 0, 0],
        oldRepeat: 0,
      ),
    ),
    expect: () => [
      ProgressState(
        progress: progress.copyWith(
          doneActions: [0, 1, 0],
          totalActions: [0, 0, 0],
        ),
        status: ProgressStatus.loaded,
      ),
    ],
  );

  blocTest<ProgressBloc, ProgressState>(
    'progress/presentation/state - emits [error] when ProgressUpdateEvent is added and usecase returns failure',
    build: () {
      when(
        () => mockUpdateTotalActionsUsecase(
          actionDays: any(named: 'actionDays'),
          repeat: any(named: 'repeat'),
          oldActionDays: any(named: 'oldActionDays'),
          oldRepeat: any(named: 'oldRepeat'),
          delete: any(named: 'delete'),
        ),
      ).thenAnswer(
        (_) => Future.value(
          Result.failure(const Failure(message: 'error message')),
        ),
      );
      return ProgressBloc(
        getProgressUsecase: mockGetProgressUsecase,
        resetProgressUsecase: mockResetProgressUsecase,
        updateActionsDoneUsecase: mockUpdateActionsDoneUsecase,
        updateTotalActionsUsecase: mockUpdateTotalActionsUsecase,
      );
    },
    seed: () => ProgressState(progress: progress),
    act: (bloc) => bloc.add(
      const ProgressUpdateEvent(
        progress: [0, 1, 0],
        repeat: 2,
        oldProgress: [0, 0, 0],
        oldRepeat: 1,
      ),
    ),
    expect: () => [
      ProgressState(
        status: ProgressStatus.error,
        error: 'error message',
      ),
    ],
  );

  blocTest<ProgressBloc, ProgressState>(
    'progress/presentation/state - emits [loaded] when ProgressResetEvent is added and usecase returns success',
    build: () {
      when(() => mockResetProgressUsecase()).thenAnswer(
        (_) => Future.value(
          Result.success(
            progress.copyWith(
              doneActions: [0, 0, 0],
              totalActions: [0, 0, 0],
            ),
          ),
        ),
      );
      return ProgressBloc(
        getProgressUsecase: mockGetProgressUsecase,
        resetProgressUsecase: mockResetProgressUsecase,
        updateActionsDoneUsecase: mockUpdateActionsDoneUsecase,
        updateTotalActionsUsecase: mockUpdateTotalActionsUsecase,
      );
    },
    seed: () => ProgressState(progress: progress),
    act: (bloc) => bloc.add(const ProgressResetEvent()),
    expect: () => [
      ProgressState(
        progress: progress.copyWith(
          doneActions: [0, 0, 0],
          totalActions: [0, 0, 0],
        ),
        status: ProgressStatus.loaded,
      ),
    ],
  );

  blocTest<ProgressBloc, ProgressState>(
    'progress/presentation/state - emits [error] when ProgressResetEvent is added and usecase returns failure',
    build: () {
      when(() => mockResetProgressUsecase()).thenAnswer(
        (_) => Future.value(
          Result.failure(const Failure(message: 'error message')),
        ),
      );
      return ProgressBloc(
        getProgressUsecase: mockGetProgressUsecase,
        resetProgressUsecase: mockResetProgressUsecase,
        updateActionsDoneUsecase: mockUpdateActionsDoneUsecase,
        updateTotalActionsUsecase: mockUpdateTotalActionsUsecase,
      );
    },
    seed: () => ProgressState(progress: progress),
    act: (bloc) => bloc.add(const ProgressResetEvent()),
    expect: () => [
      ProgressState(
        status: ProgressStatus.error,
        error: 'error message',
      ),
    ],
  );
}
