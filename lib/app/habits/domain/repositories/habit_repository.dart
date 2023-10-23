import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class HabitRepository {
  Future<Result<HabitEntity>> createHabit(HabitEntity habit);

  Future<Result<List<HabitEntity>>> readHabits();

  Future<Result<HabitEntity>> updateHabit(HabitEntity habit);

  Future<Result<HabitEntity>> deleteHabit(HabitEntity habit);

  Future<Result<HabitEntity>> resetHabitProgress(HabitEntity habit, int index);

  Future<Result<bool>> clearHabitsProgress();
}
