import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class ResetHabitProgressUsecase {
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
    required int index,
  });
}

class ResetHabitProgressUsecaseImpl extends ResetHabitProgressUsecase {
  final HabitRepository _repository;

  ResetHabitProgressUsecaseImpl({required HabitRepository repository})
      : _repository = repository;

  @override
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
    required int index,
  }) async {
    if (habit.id == null) {
      return Result.failure(const InvalidDataFailure());
    }

    if (index >= habit.progress.length || index < 0) {
      return Result.failure(const InvalidDataFailure());
    }

    return _repository.resetHabitProgress(habit, index);
  }
}
