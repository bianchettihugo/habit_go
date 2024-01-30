import 'package:flutter/foundation.dart';
import 'package:habit_go/app/reminders/data/datasources/reminder_datasource.dart';
import 'package:habit_go/app/reminders/data/datasources/reminders_datasource.local.dart';
import 'package:habit_go/app/reminders/data/repositories/reminder_repository_impl.dart';
import 'package:habit_go/app/reminders/domain/repositories/reminder_repository.dart';
import 'package:habit_go/app/reminders/domain/usecases/add_reminder_usecase.dart';
import 'package:habit_go/app/reminders/domain/usecases/delete_reminder_usecase.dart';
import 'package:habit_go/app/reminders/domain/usecases/fetch_reminders_usecase.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_bloc.dart';
import 'package:habit_go/core/services/dependency/dependency_service.dart';
import 'package:isar/isar.dart';

class RemindersModule {
  static void init() {
    Dependency.register<ReminderDatasource>(
      LocalReminderDatasource(
        isar: Dependency.get<Isar>(),
      ),
    );

    Dependency.register<ReminderRepository>(
      ReminderRepositoryImpl(
        reminderDatasource: Dependency.get<ReminderDatasource>(),
      ),
    );

    Dependency.register<AddReminderUsecase>(
      AddReminderUsecaseImpl(
        repository: Dependency.get<ReminderRepository>(),
      ),
    );

    Dependency.register<DeleteReminderUsecase>(
      DeleteReminderUsecaseImpl(
        repository: Dependency.get<ReminderRepository>(),
      ),
    );

    Dependency.register<FetchRemindersUsecase>(
      FetchRemindersUsecaseImpl(
        repository: Dependency.get<ReminderRepository>(),
      ),
    );

    Dependency.registerLazy<RemindersBloc>(
      RemindersBloc(
        fetchRemindersUsecase: Dependency.get<FetchRemindersUsecase>(),
        deleteReminderUsecase: Dependency.get<DeleteReminderUsecase>(),
        addReminderUsecase: Dependency.get<AddReminderUsecase>(),
      ),
    );

    if (kDebugMode) print('\x1B[36m-==== REMINDERS MODULE INITIALIZED ====-');
  }
}
