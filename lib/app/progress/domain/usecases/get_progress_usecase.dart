import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class GetProgressUsecase {
  Future<Result<ProgressEntity>> call();
}

class GetProgressUsecaseImpl extends GetProgressUsecase {
  final ProgressRepository _repository;

  GetProgressUsecaseImpl({required ProgressRepository repository})
      : _repository = repository;

  @override
  Future<Result<ProgressEntity>> call() async {
    return _repository.getProgress();
  }
}
