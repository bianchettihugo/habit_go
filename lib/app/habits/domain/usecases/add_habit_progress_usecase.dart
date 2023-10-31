import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/events/habits_events.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/services/events/event_service.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class AddHabitProgressUsecase {
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
    required int dayIndex,
  });
}

class AddHabitProgressUsecaseImpl extends AddHabitProgressUsecase {
  final HabitRepository _repository;
  final EventService _eventService;

  AddHabitProgressUsecaseImpl({
    required HabitRepository repository,
    required EventService eventService,
  })  : _repository = repository,
        _eventService = eventService;

  @override
  Future<Result<HabitEntity>> call({
    required HabitEntity habit,
    required int dayIndex,
  }) async {
    if (dayIndex >= habit.progress.length) {
      return Result.failure(const InvalidDataFailure());
    }

    final list = [...habit.progress];

    if (list[dayIndex] >= habit.repeat) {
      return Result.success(habit);
    }

    list[dayIndex] = list[dayIndex]++;

    final result = await _repository.updateHabit(
      habit.copyWith(
        progress: list,
      ),
    );

    if (result.data != null) {
      _eventService.add(HabitActionEvent(day: dayIndex.getDay));
    }

    return result;
  }
}
