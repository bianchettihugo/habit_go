import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/core/services/storage/storage_service.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class ResetProgressUsecase {
  Future<Result<ProgressEntity>> call();
}

class ResetProgressUsecaseImpl extends ResetProgressUsecase {
  final ProgressRepository _repository;
  final StorageService _storageService;

  ResetProgressUsecaseImpl({
    required ProgressRepository repository,
    required StorageService storageService,
  })  : _repository = repository,
        _storageService = storageService;

  @override
  Future<Result<ProgressEntity>> call() async {
    final nowMonth = DateTime.now().month;
    final nowYear = DateTime.now().year;
    final lastMonth = _storageService.getInt('lastMonth') ?? 0;
    final lastYear = _storageService.getInt('lastYear') ?? 0;

    if (nowMonth == lastMonth && nowYear == lastYear) {
      return Result.failure(const NoActionFailure());
    } else {
      await _storageService.setInt('lastMonth', nowMonth);
      await _storageService.setInt('lastYear', nowYear);
    }

    return _repository.resetProgress();
  }
}
