// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:habit_go/app/habits/domain/events/habits_events.dart';
import 'package:habit_go/app/progress/presentation/state/progress_bloc.dart';
import 'package:habit_go/app/progress/presentation/state/progress_event.dart';
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

    if (kDebugMode) print('\x1B[36m-==== APP MODULE INITIALIZED ====-');
  }
}
