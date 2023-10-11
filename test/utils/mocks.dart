import 'package:habit_go/app/habits/data/datasources/habit_datasource.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/app/progress/data/datasources/progress_datasource.dart';
import 'package:mocktail/mocktail.dart';

class MockHabitDatasource extends Mock implements HabitDatasource {}

class MockHabitRepository extends Mock implements HabitRepository {}

class MockProgressDatasource extends Mock implements ProgressDatasource {}
