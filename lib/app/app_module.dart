// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:habit_go/app/habits/domain/events/habits_events.dart';
import 'package:habit_go/app/progress/presentation/state/progress_bloc.dart';
import 'package:habit_go/app/progress/presentation/state/progress_event.dart';
import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/domain/usecases/fetch_reminders_by_habit_id_usecase.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_bloc.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_events.dart';
import 'package:habit_go/core/services/dependency/dependency_service.dart';
import 'package:habit_go/core/services/events/event_service.dart';

class AppModule {
  static void init() {
    Dependency.get<EventService>().on<HabitSavedEvent>().listen((event) {
      Dependency.get<ProgressBloc>().add(
        ProgressUpdateEvent(
          progress: event.data['days'] ?? [],
          repeat: event.data['repeat'] ?? 0,
          oldProgress: event.data['oldProgress'],
          oldRepeat: event.data['oldRepeat'],
        ),
      );
    });

    Dependency.get<EventService>().on<HabitActionEvent>().listen((event) {
      Dependency.get<ProgressBloc>().add(
        ProgressActionEvent(
          index: event.day,
        ),
      );
    });

    Dependency.get<EventService>().on<HabitDeleteEvent>().listen((event) {
      Dependency.get<ProgressBloc>().add(
        ProgressUpdateEvent(
          progress: event.entity.originalProgress,
          repeat: event.entity.repeat,
          delete: true,
        ),
      );
    });

    Dependency.get<EventService>().on<HabitResetProgressEvent>().listen(
      (event) {
        Dependency.get<ProgressBloc>().add(
          ProgressActionEvent(
            index: event.day,
            value: event.progress,
            delete: true,
          ),
        );
      },
    );

    Dependency.get<EventService>().on<HabitRemindersRequestEvent>().listen(
      (event) async {
        final result = await Dependency.get<FetchRemindersByHabitIdUsecase>()
            .call(event.habitId);
        result.when(
          success: (reminders) {
            final dates = reminders.map((e) => e.time).toList();
            Dependency.get<EventService>().add(dates);
          },
          failure: (filure) {
            Dependency.get<EventService>().add(<DateTime>[]);
          },
        );
      },
    );

    Dependency.get<EventService>()
        .on<HabitRemindersChangedEvent>()
        .listen((event) {
      final reminders = event.reminders
          .map(
            (e) => ReminderEntity(
              time: e,
              title: event.title,
              days: event.days,
            ),
          )
          .toList();
      Dependency.get<RemindersBloc>().add(
        ReminderSetEvent(
          habitId: event.habitId,
          reminders: reminders,
        ),
      );
    });

    if (kDebugMode) print('\x1B[36m-==== APP MODULE INITIALIZED ====-');
  }
}
