import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/app/progress/domain/usecases/update_total_actions_usecase.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

class MockProgressRepository extends Mock implements ProgressRepository {}

void main() {
  late UpdateTotalActionsUsecase usecase;
  late ProgressRepository repository;

  setUp(() {
    repository = MockProgressRepository();
    usecase = UpdateTotalActionsUsecaseImpl(repository: repository);
  });

  final tActionDays = [1, 1, 1, 1, 1, 1, 1];
  const tRepeat = 1;
  final tOldActionDays = [1, 1, 1, 1, 1, 1, 1];
  const tOldRepeat = 1;
  const tDelete = false;
  final tProgressEntity = ProgressEntity(totalActions: [1, 1, 1, 1, 1, 1, 1]);
  final tResult = Result.success(tProgressEntity);

  test(
      'progress/domain/usecases - should get the current progress from the repository',
      () async {
    when(() => repository.getProgress()).thenAnswer((_) async => tResult);
    when(() => repository.saveProgress(tProgressEntity))
        .thenAnswer((_) async => tResult);

    await usecase(
      actionDays: tActionDays,
      repeat: tRepeat,
      oldActionDays: tOldActionDays,
      oldRepeat: tOldRepeat,
      delete: tDelete,
    );

    verify(() => repository.getProgress());
  });

  test(
      'progress/domain/usecases - should return a failure when the progress is null',
      () async {
    when(() => repository.getProgress())
        .thenAnswer((_) async => Result.success(null));
    when(() => repository.saveProgress(tProgressEntity))
        .thenAnswer((_) async => tResult);

    final result = await usecase(
      actionDays: tActionDays,
      repeat: tRepeat,
      oldActionDays: tOldActionDays,
      oldRepeat: tOldRepeat,
      delete: tDelete,
    );

    expect(result, equals(Result.failure(const CorruptedDataFailure())));
  });

  test(
      'progress/domain/usecases - should return a failure when the actionDays length is not 7',
      () async {
    when(() => repository.getProgress()).thenAnswer((_) async => tResult);

    final result = await usecase(
      actionDays: [1, 1, 1, 1, 1, 1],
      repeat: tRepeat,
      oldActionDays: tOldActionDays,
      oldRepeat: tOldRepeat,
      delete: tDelete,
    );

    expect(result, equals(Result.failure(const InvalidDataFailure())));
  });

  test(
      'progress/domain/usecases - should return a failure when the oldActionDays length is not 7',
      () async {
    when(() => repository.getProgress()).thenAnswer((_) async => tResult);

    final result = await usecase(
      actionDays: tActionDays,
      repeat: tRepeat,
      oldActionDays: [1, 1, 1, 1, 1, 1],
      oldRepeat: tOldRepeat,
      delete: tDelete,
    );

    expect(result, equals(Result.failure(const InvalidDataFailure())));
  });

  test(
      'progress/domain/usecases - should update the totalActions list correctly',
      () async {
    when(() => repository.getProgress()).thenAnswer((_) async => tResult);
    when(() => repository.saveProgress(tProgressEntity))
        .thenAnswer((_) async => tResult);

    final result = await usecase(
      actionDays: tActionDays,
      repeat: tRepeat,
      oldActionDays: tOldActionDays,
      oldRepeat: tOldRepeat,
      delete: tDelete,
    );

    expect(result, equals(tResult));
    verify(() => repository.saveProgress(tProgressEntity));
  });

  test(
      'progress/domain/usecases - should update the totalActions list correctly when deleting',
      () async {
    when(() => repository.getProgress()).thenAnswer((_) async => tResult);
    when(
      () => repository.saveProgress(
        tProgressEntity.copyWith(totalActions: [0, 0, 0, 0, 0, 0, 0]),
      ),
    ).thenAnswer((_) async => tResult);

    await usecase(
      actionDays: tActionDays,
      repeat: tRepeat,
      delete: true,
    );

    verify(
      () => repository.saveProgress(
        tProgressEntity.copyWith(totalActions: [0, 0, 0, 0, 0, 0, 0]),
      ),
    );
  });
}
