import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class UpdateTotalActionsUsecase {
  Future<Result<ProgressEntity>> call({
    required List<int> actionDays,
    required int repeat,
    List<int>? oldActionDays,
    int? oldRepeat,
    bool delete,
  });
}

class UpdateTotalActionsUsecaseImpl extends UpdateTotalActionsUsecase {
  final ProgressRepository _repository;

  UpdateTotalActionsUsecaseImpl({required ProgressRepository repository})
      : _repository = repository;

  @override
  Future<Result<ProgressEntity>> call({
    required List<int> actionDays,
    required int repeat,
    List<int>? oldActionDays,
    int? oldRepeat,
    bool delete = false,
  }) async {
    final progressResult = await _repository.getProgress();
    final progress = progressResult.data;

    if (progress == null) {
      return Result.failure(const CorruptedDataFailure());
    }

    if (actionDays.length != 7) {
      return Result.failure(const InvalidDataFailure());
    }

    if (oldActionDays != null && oldActionDays.length != 7) {
      return Result.failure(const InvalidDataFailure());
    }

    final list = [...progress.totalActions];
    if (oldActionDays != null && oldRepeat != null) {
      for (var i = 0; i < oldActionDays.length; i++) {
        if (oldActionDays[i] >= 0) {
          list[i] -= oldRepeat;
        }
      }
    }

    for (var i = 0; i < actionDays.length; i++) {
      if (actionDays[i] >= 0) {
        list[i] += repeat * (delete ? -1 : 1);
      }
    }

    return _repository.saveProgress(
      progress.copyWith(
        totalActions: [...list],
      ),
    );
  }
}
