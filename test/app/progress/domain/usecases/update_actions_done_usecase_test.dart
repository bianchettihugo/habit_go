import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/app/progress/domain/usecases/update_actions_done_usecase.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late UpdateActionsDoneUsecase usecase;
  late MockProgressRepository mockRepository;

  setUp(() {
    registerFallbackValue(ProgressEntity());
    mockRepository = MockProgressRepository();
    usecase = UpdateActionsDoneUsecaseImpl(repository: mockRepository);
  });

  const tDay = 1;
  const tActions = 2;
  const tDelete = false;
  final tProgressEntity = ProgressEntity(
    doneActions: [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ],
  );
  final tResult = Result.success(tProgressEntity);

  test('should get the progress from the repository', () async {
    when(() => mockRepository.getProgress()).thenAnswer((_) async => tResult);
    when(() => mockRepository.saveProgress(any()))
        .thenAnswer((_) async => tResult);

    await usecase(day: tDay, actions: tActions, delete: tDelete);

    verify(() => mockRepository.getProgress());
  });

  test('should return a failure when the progress is null', () async {
    when(() => mockRepository.getProgress())
        .thenAnswer((_) async => Result.success(null));

    final result = await usecase(day: tDay, actions: tActions, delete: tDelete);

    expect(result, equals(Result.failure(const CorruptedDataFailure())));
    verify(() => mockRepository.getProgress());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a failure when the day is less than 0', () async {
    when(() => mockRepository.getProgress()).thenAnswer((_) async => tResult);

    final result = await usecase(day: -1, actions: tActions, delete: tDelete);

    expect(result, equals(Result.failure(const InvalidDataFailure())));
    verify(() => mockRepository.getProgress());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a failure when the day is greater than 30', () async {
    when(() => mockRepository.getProgress()).thenAnswer((_) async => tResult);

    final result = await usecase(day: 31, actions: tActions, delete: tDelete);

    expect(result, equals(Result.failure(const InvalidDataFailure())));
    verify(() => mockRepository.getProgress());
    verifyNoMoreInteractions(mockRepository);
  });

  test('should update the progress with the correct values', () async {
    when(() => mockRepository.getProgress()).thenAnswer((_) async => tResult);
    when(() => mockRepository.saveProgress(any()))
        .thenAnswer((_) async => tResult);

    final result = await usecase(day: tDay, actions: tActions, delete: tDelete);

    expect(result, equals(tResult));
    verify(() => mockRepository.getProgress());
    verify(
      () => mockRepository.saveProgress(
        tProgressEntity.copyWith(
          doneActions: [
            0,
            2,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
          ],
        ),
      ),
    );
    verifyNoMoreInteractions(mockRepository);
  });

  test('should update the progress with the correct values when delete is true',
      () async {
    when(() => mockRepository.getProgress()).thenAnswer((_) async => tResult);
    when(() => mockRepository.saveProgress(any()))
        .thenAnswer((_) async => tResult);

    final result = await usecase(day: tDay, actions: tActions, delete: true);

    expect(result, equals(tResult));
    verify(() => mockRepository.getProgress());
    verify(
      () => mockRepository.saveProgress(
        tProgressEntity.copyWith(
          doneActions: [
            0,
            -2,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
          ],
        ),
      ),
    );
    verifyNoMoreInteractions(mockRepository);
  });
}
