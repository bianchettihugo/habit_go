import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/app/habits/domain/usecases/clear_habits_progress_usecase.dart';
import 'package:habit_go/core/services/storage/storage_service.dart';

import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late HabitRepository repository;
  late ClearHabitsProgressUsecase clearHabitsProgress;
  late StorageService storageService;

  setUpAll(() {
    repository = MockHabitRepository();
    storageService = MockStorageService();
    clearHabitsProgress = ClearHabitsProgressUsecaseImpl(
      repository: repository,
      storageService: storageService,
    );
  });

  test(
    'habits/domain/usecases - should return false if lastMonday is same as lastMondayData',
    () async {
      final storageService = MockStorageService();
      final repository = MockHabitRepository();
      final usecase = ClearHabitsProgressUsecaseImpl(
        repository: repository,
        storageService: storageService,
      );

      final date = DateTime.now();
      final lastMonday =
          DateTime(date.year, date.month, date.day - (date.weekday - 1));
      final lastMondayData = lastMonday.day;

      when(() => storageService.getInt('lastMonday'))
          .thenReturn(lastMondayData);

      final result = await usecase();

      expect(result, Result.success(false));
      verifyNever(repository.clearHabitsProgress);
    },
  );

  test(
    'habits/domain/usecases - should call clearHabitsProgress from repository if lastMonday is not same as lastMondayData',
    () async {
      const lastMondayData = -2;
      final date = DateTime.now();
      final lastMonday =
          DateTime(date.year, date.month, date.day - (date.weekday - 1));

      when(() => storageService.getInt('lastMonday'))
          .thenReturn(lastMondayData);
      when(repository.clearHabitsProgress).thenAnswer(
        (invocation) async => Result.success(true),
      );
      when(() => storageService.setInt('lastMonday', lastMonday.day))
          .thenAnswer((_) => Future.value());

      final result = await clearHabitsProgress();

      expect(result, Result.success(true));
      verify(repository.clearHabitsProgress).called(1);
      verify(() => storageService.setInt('lastMonday', lastMonday.day))
          .called(1);
    },
  );
}
