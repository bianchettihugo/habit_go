import 'package:flutter/material.dart';
import 'package:habit_go/app/habits/data/datasources/habit_datasource.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/app/habits/domain/usecases/add_habit_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/delete_habit_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habits_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/reset_habit_progress_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/save_habit_usecase.dart';
import 'package:habit_go/app/progress/data/datasources/progress_datasource.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

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
