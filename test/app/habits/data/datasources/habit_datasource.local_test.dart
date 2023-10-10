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
      return await isar.habitModels.where().idEqualTo(0).findFirst();
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
    await datasource.updateHabit(HabitModel.fromEntity(
      habitEntity.copyWith(color: 'yellow'),
    ));
    final habit = await isar.txn(() async {
      return await isar.habitModels.where().idEqualTo(0).findFirst();
    });
    expect(habit?.color, 'yellow');
  });

  test('habits/data/datasources - should delete an habit', () async {
    await datasource.createHabit(habitModel);
    await datasource.deleteHabit(HabitModel(id: null));
    await datasource.deleteHabit(habitModel);
    final result = await datasource.readHabits();
    expect(result, isEmpty);
  });

  tearDownAll(() {
    isar.close(deleteFromDisk: true);
  });
}
