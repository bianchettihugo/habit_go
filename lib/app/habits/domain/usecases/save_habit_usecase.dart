import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/events/habits_events.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/services/events/event_service.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class SaveHabitUsecase {
  Future<Result<HabitEntity>> call({
    required Map<String, dynamic> data,
  });
}

class SaveHabitUsecaseImpl extends SaveHabitUsecase {
  final HabitRepository _repository;
  final EventService _eventService;

  SaveHabitUsecaseImpl({
    required HabitRepository repository,
    required EventService eventService,
  })  : _repository = repository,
        _eventService = eventService;

  @override
  Future<Result<HabitEntity>> call({
    required Map<String, dynamic> data,
  }) async {
    final rules = [
      data['id'] == null || int.tryParse(data['id'].toString()) != null,
      data['name'] != null && data['name'].toString().isNotEmpty,
      data['repeat'] != null && int.tryParse(data['repeat'].toString()) != null,
      data['days'] != null && data['days'] is List<int>,
      data['notify'] != null && data['notify'] is bool,
      data['type'] != null && data['type'] is Map,
      data['type'] is Map && data['type'].containsKey('icon'),
    ];

    if (rules.contains(false)) {
      return Result.failure(const InvalidDataFailure());
    }

    final id = int.tryParse(data['id']?.toString() ?? '');
    final habit = HabitEntity(
      id: id,
      title: data['name'].toString(),
      repeat: int.tryParse(data['repeat'].toString()) ?? 1,
      originalProgress: data['days'],
      progress: data['days'],
      reminder: data['notify'],
      icon: data['type']['icon'].toString(),
      color: 'primary',
    );

    final result = await (id != null
        ? _repository.updateHabit(habit)
        : _repository.createHabit(habit));

    if (result.data != null) {
      _eventService.add(HabitSavedEvent(data: data));
      if (data['reminders'] != null) {
        final dates = <DateTime>[];
        for (final reminder in data['reminders'].values) {
          if (reminder != null) {
            dates.add(reminder);
          }
        }
        _eventService.add(
          HabitRemindersChangedEvent(
            habitId: result.data!.id!,
            reminders: dates,
            days: data['days'],
            title: data['name'].toString(),
          ),
        );
      }
    }

    return result;
  }
}
