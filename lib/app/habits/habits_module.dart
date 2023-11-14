// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:habit_go/app/habits/data/datasources/habit_datasource.dart';
import 'package:habit_go/app/habits/data/datasources/habit_datasource.local.dart';
import 'package:habit_go/app/habits/data/repositories/habit_repository_impl.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/app/habits/domain/usecases/add_habit_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/check_habit_reminder_permissions_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/clear_habits_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habits_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/reset_habit_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/save_habit_usecase.dart';
import 'package:habit_go/app/habits/presentation/state/habits_bloc.dart';
import 'package:habit_go/core/services/dependency/dependency_service.dart';
import 'package:habit_go/core/services/events/event_service.dart';
import 'package:habit_go/core/services/notifications/notification_service.dart';
import 'package:habit_go/core/services/storage/storage_service.dart';
import 'package:isar/isar.dart';

class HabitsModule {
  static void init() {
    Dependency.register<HabitDatasource>(
      LocalHabitDatasource(
        isar: Dependency.get<Isar>(),
      ),
    );

    Dependency.register<HabitRepository>(
      HabitRepositoryImpl(
        habitDatasource: Dependency.get<HabitDatasource>(),
      ),
    );

    Dependency.register<FetchHabitsUsecase>(
      FetchHabitsUsecaseImpl(
        repository: Dependency.get<HabitRepository>(),
      ),
    );

    Dependency.register<SaveHabitUsecase>(
      SaveHabitUsecaseImpl(
        repository: Dependency.get<HabitRepository>(),
        eventService: Dependency.get<EventService>(),
      ),
    );

    Dependency.register<DeleteHabitUsecase>(
      DeleteHabitUsecaseImpl(
        repository: Dependency.get<HabitRepository>(),
        eventService: Dependency.get<EventService>(),
      ),
    );

    Dependency.register<AddHabitProgressUsecase>(
      AddHabitProgressUsecaseImpl(
        repository: Dependency.get<HabitRepository>(),
        eventService: Dependency.get<EventService>(),
      ),
    );

    Dependency.register<ClearHabitsProgressUsecase>(
      ClearHabitsProgressUsecaseImpl(
        repository: Dependency.get<HabitRepository>(),
        storageService: Dependency.get<StorageService>(),
      ),
    );

    Dependency.register<ResetHabitProgressUsecase>(
      ResetHabitProgressUsecaseImpl(
        repository: Dependency.get<HabitRepository>(),
        eventService: Dependency.get<EventService>(),
      ),
    );

    Dependency.register<CheckHabitReminderPermissionsUsecase>(
      CheckHabitReminderPermissionsUsecaseImpl(
        notificationService: Dependency.get<NotificationService>(),
      ),
    );

    Dependency.registerLazy(
      HabitsBloc(
        fetchHabitsUsecase: Dependency.get<FetchHabitsUsecase>(),
        deleteHabitsUsecase: Dependency.get<DeleteHabitUsecase>(),
        saveHabitsUsecase: Dependency.get<SaveHabitUsecase>(),
        resetHabitUsecase: Dependency.get<ResetHabitProgressUsecase>(),
        addHabitProgressUsecase: Dependency.get<AddHabitProgressUsecase>(),
        clearHabitProgress: Dependency.get<ClearHabitsProgressUsecase>(),
      ),
    );

    if (kDebugMode) print('\x1B[36m-==== HABITS MODULE INITIALIZED ====-');
  }
}
