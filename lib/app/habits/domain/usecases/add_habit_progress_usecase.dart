import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class AddHabitProgressUsecase {
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
    required int dayIndex,
  });
}

class AddHabitProgressUsecaseImpl extends AddHabitProgressUsecase {
  final HabitRepository _repository;

  AddHabitProgressUsecaseImpl({required HabitRepository repository})
      : _repository = repository;

  @override
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
    required int dayIndex,
  }) async {
    if (dayIndex >= habit.progress.length) {
      return Result.failure(const InvalidDataFailure());
    }

    final list = [...habit.progress];

    if (list[dayIndex] >= habit.repeat) {
      return Result.success(habit);
    }

    list[dayIndex] = list[dayIndex]++;

    return _repository.updateHabit(
      habit.copyWith(
        progress: list,
      ),
    );
  }
}
