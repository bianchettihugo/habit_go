import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/app/habits/domain/usecases/clear_habits_progress_usecase.dart';

import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late HabitRepository repository;
  late CleatHabitsProgressUsecase clearHabitsProgress;

  setUpAll(() {
    repository = MockHabitRepository();
    clearHabitsProgress =
        CleatHabitsProgressUsecaseImpl(repository: repository);
  });

  test(
      'habits/domain/usecases - should call clear habits progress from repository',
      () async {
    when(() => repository.clearHabitsProgress()).thenAnswer(
      (invocation) async => Result.success(true),
    );

    final result = await clearHabitsProgress();
    expect(result, Result.success(true));
  });
}
