import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/app/habits/domain/usecases/save_habit_usecase.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late HabitRepository repository;
  late SaveHabitUsecase saveHabit;

  final habit = HabitEntity(
    id: null,
    title: 'title',
    icon: 'ic-close',
    color: 'primary',
    repeat: 4,
    progress: [2, 3, 2],
    reminder: true,
  );

  setUpAll(() async {
    repository = MockHabitRepository();
    saveHabit = SaveHabitUsecaseImpl(repository: repository);
  });

  test(
      'habits/domain/usecases - should call create habit from repository when id is null',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final result = await saveHabit(data: habitData1);

    expect(result, Result.success(habit));
    verify(() => repository.createHabit(habit)).called(1);
    verifyNever(() => repository.updateHabit(habit));
  });

  test(
      'habits/domain/usecases - should call update habit from repository when id is not null',
      () async {
    when(() => repository.updateHabit(habitEntity)).thenAnswer(
      (invocation) async => Result.success(habitEntity),
    );

    final result = await saveHabit(data: habitData2);

    expect(result, Result.success(habitEntity));
    verify(() => repository.updateHabit(habitEntity)).called(1);
    verifyNever(() => repository.createHabit(habitEntity));
  });

  test(
      'habits/domain/usecases - should return a failure when id it not null and it is not a valid integer',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': true,
      'name': 'title',
      'repeat': '4',
      'days': [2, 3, 2],
      'notify': true,
      'type': {
        'icon': 'ic-close',
        'color': 'primary',
      },
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test('habits/domain/usecases - should return a failure when name is null',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'repeat': '4',
      'days': [2, 3, 2],
      'notify': true,
      'type': {
        'icon': 'ic-close',
        'color': 'primary',
      },
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test('habits/domain/usecases - should return a failure when name is empty',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'name': '',
      'repeat': '4',
      'days': [2, 3, 2],
      'notify': true,
      'type': {
        'icon': 'ic-close',
        'color': 'primary',
      },
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test('habits/domain/usecases - should return a failure when repeat is null',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'name': 'name',
      'days': [2, 3, 2],
      'notify': true,
      'type': {
        'icon': 'ic-close',
        'color': 'primary',
      },
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test(
      'habits/domain/usecases - should return a failure when repeat is not a valid integer',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'repeat': true,
      'name': 'DDWWW',
      'days': [2, 3, 2],
      'notify': true,
      'type': {
        'icon': 'ic-close',
        'color': 'primary',
      },
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test('habits/domain/usecases - should return a failure when days is null',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'repeat': '4',
      'name': 'DDWWW',
      'notify': true,
      'type': {
        'icon': 'ic-close',
        'color': 'primary',
      },
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test(
      'habits/domain/usecases - should return a failure when days is not a list',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'repeat': '4',
      'name': 'DDWWW',
      'days': 'lob',
      'notify': true,
      'type': {
        'icon': 'ic-close',
        'color': 'primary',
      },
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test('habits/domain/usecases - should return a failure when notify is null',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'name': 'name',
      'days': [2, 3, 2],
      'repeat': '4',
      'type': {
        'icon': 'ic-close',
        'color': 'primary',
      },
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test(
      'habits/domain/usecases - should return a failure when notify is not boolean',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'name': 'name',
      'days': [2, 3, 2],
      'repeat': '4',
      'notify': 33,
      'type': {
        'icon': 'ic-close',
        'color': 'primary',
      },
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test('habits/domain/usecases - should return a failure when type is null',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'name': 'name',
      'days': [2, 3, 2],
      'repeat': '4',
      'notify': true,
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test(
      'habits/domain/usecases - should return a failure when type is not a map',
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'name': 'name',
      'days': [2, 3, 2],
      'repeat': '4',
      'notify': true,
      'type': true,
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test(
      "habits/domain/usecases - should return a failure when type doesn't have icon",
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'name': 'name',
      'days': [2, 3, 2],
      'repeat': '4',
      'notify': true,
      'type': {
        'color': 'primary',
      },
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });

  test(
      "habits/domain/usecases - should return a failure when type doesn't have color",
      () async {
    when(() => repository.createHabit(habit)).thenAnswer(
      (invocation) async => Result.success(habit),
    );

    final data = {
      'id': null,
      'name': 'name',
      'days': [2, 3, 2],
      'repeat': '4',
      'notify': true,
      'type': {
        'icon': 'ic-close',
      },
    };
    final result = await saveHabit(data: data);

    expect(result, Result.failure(const InvalidDataFailure()));
    verifyNever(() => repository.createHabit(habit));
  });
}
