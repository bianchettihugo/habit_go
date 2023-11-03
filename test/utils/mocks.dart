import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:habit_go/app/habits/data/datasources/habit_datasource.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/app/habits/domain/usecases/add_habit_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habits_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/reset_habit_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/save_habit_usecase.dart';
import 'package:habit_go/app/habits/presentation/state/habits_bloc.dart';
import 'package:habit_go/app/habits/presentation/state/habits_event.dart';
import 'package:habit_go/app/habits/presentation/state/habits_state.dart';
import 'package:habit_go/app/progress/data/datasources/progress_datasource.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/app/progress/domain/usecases/get_progress_usecase.dart';
import 'package:habit_go/app/progress/domain/usecases/reset_progress_usecase.dart';
import 'package:habit_go/app/progress/domain/usecases/update_actions_done_usecase.dart';
import 'package:habit_go/app/progress/domain/usecases/update_total_actions_usecase.dart';
import 'package:habit_go/app/progress/presentation/state/progress_bloc.dart';
import 'package:habit_go/app/progress/presentation/state/progress_event.dart';
import 'package:habit_go/app/progress/presentation/state/progress_state.dart';
import 'package:habit_go/app/reminders/domain/repositories/reminder_repository.dart';
import 'package:habit_go/app/reminders/domain/usecases/add_reminder_usecase.dart';
import 'package:habit_go/app/reminders/domain/usecases/delete_reminder_usecase.dart';
import 'package:habit_go/app/reminders/domain/usecases/fetch_reminders_usecase.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_bloc.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_events.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_state.dart';
import 'package:habit_go/app/settings/data/datasources/settings_datasource.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';
import 'package:habit_go/app/settings/domain/repositories/settings_repository.dart';
import 'package:habit_go/app/settings/presentation/state/settings_cubit.dart';
import 'package:habit_go/core/services/events/event_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockEventService extends Mock implements EventService {
  @override
  void add(dynamic event) {}

  @override
  void destroy() {}

  @override
  Stream<T> on<T>() {
    return const Stream.empty();
  }

  @override
  StreamController get streamController => throw UnimplementedError();
}

class MockHabitDatasource extends Mock implements HabitDatasource {}

class MockHabitRepository extends Mock implements HabitRepository {}

class MockProgressDatasource extends Mock implements ProgressDatasource {}

class MockProgressRepository extends Mock implements ProgressRepository {}

class MockFetchHabitsUsecase extends Mock implements FetchHabitsUsecase {}

class MockDeleteHabitUsecase extends Mock implements DeleteHabitUsecase {}

class MockSaveHabitUsecase extends Mock implements SaveHabitUsecase {}

class MockResetHabitProgressUsecase extends Mock
    implements ResetHabitProgressUsecase {}

class MockAddHabitProgressUsecase extends Mock
    implements AddHabitProgressUsecase {}

class MockHabitsBloc extends MockBloc<HabitEvent, HabitState>
    implements HabitsBloc {}

class MockGetProgressUsecase extends Mock implements GetProgressUsecase {}

class MockResetProgressUsecase extends Mock implements ResetProgressUsecase {}

class MockUpdateActionsDoneUsecase extends Mock
    implements UpdateActionsDoneUsecase {}

class MockUpdateTotalActionsUsecase extends Mock
    implements UpdateTotalActionsUsecase {}

class MockProgressBloc extends MockBloc<ProgressEvent, ProgressState>
    implements ProgressBloc {}

class MockReminderRepository extends Mock implements ReminderRepository {}

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockSettingsDatasource extends Mock implements SettingsDatasource {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

class MockFetchRemindersUsecase extends Mock implements FetchRemindersUsecase {}

class MockDeleteReminderUsecase extends Mock implements DeleteReminderUsecase {}

class MockAddReminderUsecase extends Mock implements AddReminderUsecase {}

class MockReminderBloc extends MockBloc<ReminderEvent, ReminderState>
    implements RemindersBloc {}

class MockSettingsCubit extends MockCubit<SettingsEntity>
    implements SettingsCubit {}
