import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class DeleteHabitUsecase {
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
  });
}

class DeleteHabitUsecaseImpl extends DeleteHabitUsecase {
  final HabitRepository _repository;

  DeleteHabitUsecaseImpl({required HabitRepository repository})
      : _repository = repository;

  @override
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
  }) async {
    if (habit.id == null) {
      return Result.failure(const InvalidDataFailure());
    }

    return _repository.deleteHabit(habit);
  }
}
