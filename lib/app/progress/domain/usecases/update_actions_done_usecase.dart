import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class UpdateActionsDoneUsecase {
  Future<Result<ProgressEntity>> call({
    required int day,
    int actions = 1,
    bool delete = false,
  });
}

class UpdateActionsDoneUsecaseImpl extends UpdateActionsDoneUsecase {
  final ProgressRepository _repository;

  UpdateActionsDoneUsecaseImpl({required ProgressRepository repository})
      : _repository = repository;

  @override
  Future<Result<ProgressEntity>> call({
    required int day,
    int actions = 1,
    bool delete = false,
  }) async {
    final progressResult = await _repository.getProgress();
    final progress = progressResult.data;

    if (progress == null) {
      return Result.failure(const CorruptedDataFailure());
    }

    if (day < 0 || day > 30) {
      return Result.failure(const InvalidDataFailure());
    }

    final list = [...progress.doneActions];
    list[day] += actions * (delete ? -1 : 1);

    return _repository.saveProgress(
      progress.copyWith(
        doneActions: [...list],
      ),
    );
  }
}
