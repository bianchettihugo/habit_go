import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/services/storage/storage_service.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class ClearHabitsProgressUsecase {
  Future<Result<bool>> call();
}

class ClearHabitsProgressUsecaseImpl extends ClearHabitsProgressUsecase {
  final HabitRepository _repository;
  final StorageService _storageService;

  ClearHabitsProgressUsecaseImpl({
    required HabitRepository repository,
    required StorageService storageService,
  })  : _repository = repository,
        _storageService = storageService;

  @override
  Future<Result<bool>> call() async {
    final lastMondayData = _storageService.getInt('lastMonday') ?? 0;
    final date = DateTime.now();
    final lastMonday =
        DateTime(date.year, date.month, date.day - (date.weekday - 1));

    if (lastMonday.day == lastMondayData) {
      return Result.success(false);
    } else {
      await _storageService.setInt('lastMonday', lastMonday.day);
    }

    return _repository.clearHabitsProgress();
  }
}
