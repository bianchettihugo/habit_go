import 'package:habit_go/app/habits/data/models/habit_model.dart';

abstract class HabitDatasource {
  Future<HabitModel> createHabit(HabitModel habit);

  Future<List<HabitModel>> readHabits();

  Future<HabitModel> updateHabit(HabitModel habit);

  Future<HabitModel> deleteHabit(HabitModel habit);

  Future<HabitModel> resetHabitProgress(HabitModel habit, int index);

  Future<void> clearHabitsProgress();
}
