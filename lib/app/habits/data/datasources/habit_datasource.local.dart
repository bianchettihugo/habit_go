import 'package:habit_go/app/habits/data/datasources/habit_datasource.dart';
import 'package:habit_go/app/habits/data/models/habit_model.dart';
import 'package:isar/isar.dart';

class LocalHabitDatasource extends HabitDatasource {
  final Isar _isar;

  LocalHabitDatasource({
    required Isar isar,
  }) : _isar = isar;

  @override
  Future<HabitModel> createHabit(HabitModel habit) async {
    final id = await _isar.writeTxn(() async {
      return _isar.habitModels.put(habit);
    });

    return habit.copyWith(id: id);
  }

  @override
  Future<List<HabitModel>> readHabits() async {
    var items = <HabitModel>[];
    await _isar.txn(() async {
      items = await _isar.habitModels.where().findAll();
    });
    return items;
  }

  @override
  Future<HabitModel> updateHabit(HabitModel habit) async {
    final id = await _isar.writeTxn(() async {
      return _isar.habitModels.put(habit);
    });

    return habit.copyWith(id: id);
  }

  @override
  Future<HabitModel> deleteHabit(HabitModel habit) async {
    await _isar.writeTxn(() async {
      await _isar.habitModels.delete(habit.id ?? -1);
    });

    return habit;
  }

  @override
  Future<HabitModel> resetHabitProgress(HabitModel habit, int index) async {
    final list = [...habit.progress];
    list[index] = habit.originalProgress[index];

    await _isar.writeTxn(() async {
      await _isar.habitModels.put(
        habit.copyWith(
          progress: list,
        ),
      );
    });

    return habit.copyWith(
      progress: list,
    );
  }

  @override
  Future<void> clearHabitsProgress() async {
    await _isar.writeTxn(() async {
      final items = await _isar.habitModels.where().findAll();
      for (final element in items) {
        await _isar.habitModels.put(
          element.copyWith(
            progress: [...element.originalProgress],
          ),
        );
      }
    });
  }
}
