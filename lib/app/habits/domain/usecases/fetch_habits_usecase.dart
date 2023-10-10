import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class FetchHabitsUsecase {
  Future<Result<List<HabitEntity>>> call();
}

class FetchHabitsUsecaseImpl extends FetchHabitsUsecase {
  final HabitRepository _repository;

  FetchHabitsUsecaseImpl({required HabitRepository repository})
      : _repository = repository;

  @override
  Future<Result<List<HabitEntity>>> call() async {
    return _repository.readHabits();
  }
}
