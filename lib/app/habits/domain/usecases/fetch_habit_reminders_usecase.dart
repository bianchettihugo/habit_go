import 'package:habit_go/app/habits/domain/events/habits_events.dart';
import 'package:habit_go/core/services/events/event_service.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class FetchHabitReminderUsecase {
  Future<Result<List<DateTime>>> call({
    required int habitId,
  });
}

class FetchHabitReminderUsecaseImpl extends FetchHabitReminderUsecase {
  final EventService _eventService;

  FetchHabitReminderUsecaseImpl({
    required EventService eventService,
  }) : _eventService = eventService;

  @override
  Future<Result<List<DateTime>>> call({required int habitId}) async {
    final result = await _eventService.addAndWait<List<DateTime>>(
      HabitRemindersRequestEvent(habitId: habitId),
    );
    return Result.success(result);
  }
}
