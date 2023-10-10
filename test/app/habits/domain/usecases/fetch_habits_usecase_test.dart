import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habits_usecase.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late HabitRepository repository;
  late FetchHabitsUsecase fetchHabits;

  setUpAll(() {
    repository = MockHabitRepository();
    fetchHabits = FetchHabitsUsecaseImpl(repository: repository);
  });

  test('habits/domain/usecases - should call read habits from repository',
      () async {
    when(() => repository.readHabits()).thenAnswer(
      (invocation) async => Result.success([habitEntity]),
    );

    final result = await fetchHabits();
    expect(result.data?[0], habitEntity);
  });
}
