import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class SaveProgressUsecase {
  Future<Result<ProgressEntity>> call({
    required ProgressEntity progress,
  });
}

class SaveProgressUsecaseImpl extends SaveProgressUsecase {
  final ProgressRepository _repository;

  SaveProgressUsecaseImpl({required ProgressRepository repository})
      : _repository = repository;

  @override
  Future<Result<ProgressEntity>> call({
    required ProgressEntity progress,
  }) async {
    return _repository.saveProgress(progress);
  }
}
