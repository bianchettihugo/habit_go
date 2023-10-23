import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class CleatHabitsProgressUsecase {
  Future<Result<bool>> call();
}

class CleatHabitsProgressUsecaseImpl extends CleatHabitsProgressUsecase {
  final HabitRepository _repository;

  CleatHabitsProgressUsecaseImpl({required HabitRepository repository})
      : _repository = repository;

  @override
  Future<Result<bool>> call() async {
    return _repository.clearHabitsProgress();
  }
}
