import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/app/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late HabitRepository repository;
  late DeleteHabitUsecase deleteHabit;

  setUpAll(() {
    repository = MockHabitRepository();
    deleteHabit = DeleteHabitUsecaseImpl(repository: repository);
  });

  test('habits/domain/usecases - should call delete habits from repository',
      () async {
    when(() => repository.deleteHabit(habitEntity)).thenAnswer(
      (invocation) async => Result.success(habitEntity),
    );

    final result = await deleteHabit(habit: habitEntity);
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
      reminder: true,
    );

    when(() => repository.deleteHabit(data)).thenAnswer(
      (invocation) async => Result.success(data),
    );

    final result = await deleteHabit(habit: data);
    expect(result, Result.failure(const InvalidDataFailure()));
  });
}
