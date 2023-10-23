import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/usecases/add_habit_progress_usecase.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late AddHabitProgressUsecase addHabitProgress;
  late MockHabitRepository mockRepository;

  setUp(() {
    mockRepository = MockHabitRepository();
    addHabitProgress = AddHabitProgressUsecaseImpl(repository: mockRepository);
  });

  test('should return a HabitEntity with updated progress', () async {
    const dayIndex = 0;
    final updatedHabit = habitEntity.copyWith(progress: [3, 3, 2]);
    when(() => mockRepository.updateHabit(habitEntity))
        .thenAnswer((_) async => Result.success(updatedHabit));

    final result = await addHabitProgress(
      habit: habitEntity,
      dayIndex: dayIndex,
    );

    expect(result, equals(Result.success(updatedHabit)));
    verify(() => mockRepository.updateHabit(habitEntity));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a Failure when dayIndex is out of bounds', () async {
    const dayIndex = 35;

    final result =
        await addHabitProgress.call(habit: habitEntity, dayIndex: dayIndex);

    expect(result, equals(Result.failure(const InvalidDataFailure())));
    verifyZeroInteractions(mockRepository);
  });

  test('should return a HabitEntity without updating progress', () async {
    const dayIndex = 0;
    final updatedHabit = habitEntity.copyWith(progress: [4, 0, 0, 0, 0]);

    final result =
        await addHabitProgress.call(habit: updatedHabit, dayIndex: dayIndex);

    expect(result, equals(Result.success(updatedHabit)));
    verifyZeroInteractions(mockRepository);
  });
}
