import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/app/habits/domain/usecases/reset_habit_progress_usecase.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late HabitRepository repository;
  late ResetHabitProgressUsecase resetHabitProgress;

  setUpAll(() {
    repository = MockHabitRepository();
    resetHabitProgress = ResetHabitProgressUsecaseImpl(repository: repository);
  });

  test('habits/domain/usecases - should call reset habit from repository',
      () async {
    when(() => repository.resetHabitProgress(habitEntity, 0)).thenAnswer(
      (invocation) async => Result.success(habitEntity),
    );

    final result = await resetHabitProgress(habit: habitEntity, index: 0);
    expect(result, Result.success(habitEntity));
  });

  test('habits/domain/usecases - should return failure when id is null',
      () async {
    final data = HabitEntity(
      id: null,
      title: 'title',
      icon: 'icon',
      color: 'color',
      repeat: 4,
      progress: [0, 0],
      originalProgress: [0, 0],
      reminder: true,
    );

    when(() => repository.resetHabitProgress(data, 0)).thenAnswer(
      (invocation) async => Result.success(data),
    );

    final result = await resetHabitProgress(habit: data, index: 0);
    expect(result, Result.failure(const InvalidDataFailure()));
  });

  test('habits/domain/usecases - should return failure when index is invalid',
      () async {
    when(() => repository.resetHabitProgress(habitEntity, 0)).thenAnswer(
      (invocation) async => Result.success(habitEntity),
    );

    final result = await resetHabitProgress(habit: habitEntity, index: 22);
    expect(result, Result.failure(const InvalidDataFailure()));
  });
}
