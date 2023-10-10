import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/data/datasources/habit_datasource.dart';
import 'package:habit_go/app/habits/data/models/habit_model.dart';
import 'package:habit_go/app/habits/data/repositories/habit_repository_impl.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late HabitDatasource datasource;
  late HabitRepository repository;

  setUpAll(() {
    datasource = MockHabitDatasource();
    repository = HabitRepositoryImpl(habitDatasource: datasource);
  });

  test('habits/data/repositories - should create an habit', () async {
    when(() => datasource.createHabit(habitModel)).thenAnswer(
      (invocation) async => habitModel,
    );
    final result = await repository.createHabit(habitEntity);
    expect(result, Result.success(habitEntity));
    verify(() => datasource.createHabit(habitModel)).called(1);
  });

  test('habits/data/repositories - should fetch habits list', () async {
    when(() => datasource.readHabits()).thenAnswer(
      (invocation) async => [habitModel],
    );
    final result = await repository.readHabits();
    expect(result.data![0], habitEntity);
    verify(() => datasource.readHabits()).called(1);
  });

  test('habits/data/repositories - should update an habit', () async {
    final model = HabitModel(
      id: 0,
      title: 'title modified',
      icon: 'ic-close',
      color: 'primary',
      repeat: 4,
      progress: [2, 3, 2],
      reminder: true,
    );
    when(() => datasource.updateHabit(model)).thenAnswer(
      (invocation) async => model,
    );

    final result = await repository.updateHabit(
      habitEntity.copyWith(
        title: 'title modified',
      ),
    );

    expect(
      result,
      Result.success(
        habitEntity.copyWith(
          title: 'title modified',
        ),
      ),
    );

    verify(() => datasource.updateHabit(model)).called(1);
  });

  test('habits/data/repositories - should delete an habit', () async {
    when(() => datasource.deleteHabit(habitModel)).thenAnswer(
      (invocation) async => habitModel,
    );
    final result = await repository.deleteHabit(habitEntity);
    expect(result, Result.success(habitEntity));
    verify(() => datasource.deleteHabit(habitModel)).called(1);
  });

  test('habits/data/repositories - should handle corrupted data failure',
      () async {
    when(() => datasource.deleteHabit(habitModel)).thenThrow(TypeError());
    final result = await repository.deleteHabit(habitEntity);
    expect(result, Result.failure(const CorruptedDataFailure()));
    verify(() => datasource.deleteHabit(habitModel)).called(1);
  });

  test('habits/data/repositories - should handle database failure', () async {
    when(() => datasource.deleteHabit(habitModel)).thenThrow(DatabaseError(''));
    final result = await repository.deleteHabit(habitEntity);
    expect(result, Result.failure(const DatabaseFailure()));
    verify(() => datasource.deleteHabit(habitModel)).called(1);
  });

  test('habits/data/repositories - should handle database index failure',
      () async {
    when(() => datasource.deleteHabit(habitModel))
        .thenThrow(DatabaseIndexError());
    final result = await repository.deleteHabit(habitEntity);
    expect(result, Result.failure(const DatabaseFailure()));
    verify(() => datasource.deleteHabit(habitModel)).called(1);
  });

  test('habits/data/repositories - should handle others failures', () async {
    when(() => datasource.deleteHabit(habitModel)).thenThrow(Exception(''));
    final result = await repository.deleteHabit(habitEntity);
    expect(result, Result.failure(const Failure()));
    verify(() => datasource.deleteHabit(habitModel)).called(1);
  });
}
