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
    await _isar.writeTxn(() async {
      return _isar.habitModels.put(habit);
    });

    return habit;
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
    await _isar.writeTxn(() async {
      return _isar.habitModels.put(habit);
    });

    return habit;
  }

  @override
  Future<HabitModel> deleteHabit(HabitModel habit) async {
    await _isar.writeTxn(() async {
      await _isar.habitModels.delete(habit.id ?? -1);
    });

    return habit;
  }
}
