import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/events/habits_events.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/services/events/event_service.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class ResetHabitProgressUsecase {
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
    required int index,
  });
}

class ResetHabitProgressUsecaseImpl extends ResetHabitProgressUsecase {
  final HabitRepository _repository;
  final EventService _eventService;

  ResetHabitProgressUsecaseImpl({
    required HabitRepository repository,
    required EventService eventService,
  })  : _repository = repository,
        _eventService = eventService;

  @override
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
    required int index,
  }) async {
    if (habit.id == null) {
      return Result.failure(const InvalidDataFailure());
    }

    if (index >= habit.progress.length || index < 0) {
      return Result.failure(const InvalidDataFailure());
    }

    final result = await _repository.resetHabitProgress(habit, index);

    if (result.data != null) {
      _eventService.add(
        HabitResetProgressEvent(
          day: index.getDay,
          progress: habit.progress[index],
        ),
      );
    }

    return result;
  }
}
