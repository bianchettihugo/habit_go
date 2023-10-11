import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class ResetProgressUsecase {
  Future<Result<bool>> call();
}

class ResetProgressUsecaseImpl extends ResetProgressUsecase {
  final ProgressRepository _repository;

  ResetProgressUsecaseImpl({required ProgressRepository repository})
      : _repository = repository;

  @override
  Future<Result<bool>> call() async {
    return _repository.resetProgress();
  }
}
