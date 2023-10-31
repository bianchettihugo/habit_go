import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/app/habits/presentation/state/habits_event.dart';
import 'package:habit_go/core/services/events/event_service.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class DeleteHabitUsecase {
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
  });
}

class DeleteHabitUsecaseImpl extends DeleteHabitUsecase {
  final HabitRepository _repository;
  final EventService _eventService;

  DeleteHabitUsecaseImpl({
    required HabitRepository repository,
    required EventService eventService,
  })  : _repository = repository,
        _eventService = eventService;

  @override
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
  }) async {
    if (habit.id == null) {
      return Result.failure(const InvalidDataFailure());
    }

    final result = await _repository.deleteHabit(habit);

    if (result.data != null) {
      _eventService.add(HabitDeleteEvent(habit));
    }

    return result;
  }
}
