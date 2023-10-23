import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/data/datasources/habit_datasource.dart';
import 'package:habit_go/app/habits/data/datasources/habit_datasource.local.dart';
import 'package:habit_go/app/habits/data/models/habit_model.dart';
import 'package:isar/isar.dart';

import '../../../../utils/data.dart';

void main() {
  late Isar isar;
  late HabitDatasource datasource;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([HabitModelSchema], directory: '');
    datasource = LocalHabitDatasource(isar: isar);
  });

  test('habits/data/datasources - should create an habit', () async {
    final result = await datasource.createHabit(habitModel);
    final habit = await isar.txn(() async {
      return isar.habitModels.where().idEqualTo(0).findFirst();
    });
    expect(result, habitModel);
    expect(habit, habitModel);
  });

  test('habits/data/datasources - should fetch habits list', () async {
    await datasource.createHabit(habitModel);
    await datasource.createHabit(habitModel);
    final result = await datasource.readHabits();
    expect(result[0], habitModel);
  });

  test('habits/data/datasources - should update an habit', () async {
    await datasource.updateHabit(
      HabitModel.fromEntity(
        habitEntity.copyWith(color: 'yellow'),
      ),
    );
    final habit = await isar.txn(() async {
      return isar.habitModels.where().idEqualTo(0).findFirst();
    });
    expect(habit?.color, 'yellow');
  });

  test('habits/data/datasources - should delete an habit', () async {
    await datasource.createHabit(habitModel);
    await datasource.deleteHabit(HabitModel());
    await datasource.deleteHabit(habitModel);
    final result = await datasource.readHabits();
    expect(result, isEmpty);
  });

  tearDownAll(() {
    isar.close(deleteFromDisk: true);
  });

  test('habits/data/datasources - should reset habits progress', () async {
    await datasource.createHabit(habitModel);
    await datasource.resetHabitProgress(habitModel, 0);
    final result = await datasource.readHabits();
    expect(result[0].progress[0], habitModel.originalProgress[0]);
  });

  test('habits/data/datasources - should clear habits progress', () async {
    await datasource.createHabit(
      habitModel.copyWith(
        originalProgress: [1, 1],
        progress: [3, 3],
      ),
    );
    await datasource.createHabit(
      habitModel.copyWith(
        id: 2,
        progress: [1, 1],
        originalProgress: [0, 0],
      ),
    );

    await datasource.clearHabitsProgress();
    final result = await datasource.readHabits();
    expect(result[0].progress, [1, 1]);
    expect(result[1].progress, [0, 0]);
  });
}
