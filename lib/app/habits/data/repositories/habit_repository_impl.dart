import 'package:habit_go/app/habits/data/datasources/habit_datasource.dart';
import 'package:habit_go/app/habits/data/models/habit_model.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

class HabitRepositoryImpl extends HabitRepository {
  final HabitDatasource habitDatasource;

  HabitRepositoryImpl({required this.habitDatasource});

  @override
  Future<Result<HabitEntity>> createHabit(HabitEntity habit) {
    return _handle<HabitEntity>(() async {
      final result = await habitDatasource.createHabit(
        HabitModel.fromEntity(habit),
      );
      return Result.success(result.toEntity());
    });
  }

  @override
  Future<Result<HabitEntity>> deleteHabit(HabitEntity habit) {
    return _handle<HabitEntity>(() async {
      final result = await habitDatasource.deleteHabit(
        HabitModel.fromEntity(habit),
      );
      return Result.success(result.toEntity());
    });
  }

  @override
  Future<Result<List<HabitEntity>>> readHabits() {
    return _handle<List<HabitEntity>>(() async {
      final list = <HabitEntity>[];
      final result = await habitDatasource.readHabits();
      for (final element in result) {
        list.add(element.toEntity());
      }

      return Result.success(list);
    });
  }

  @override
  Future<Result<HabitEntity>> updateHabit(HabitEntity habit) {
    return _handle<HabitEntity>(() async {
      final result = await habitDatasource.updateHabit(
        HabitModel.fromEntity(habit),
      );
      return Result.success(result.toEntity());
    });
  }

  @override
  Future<Result<bool>> clearHabitsProgress() {
    return _handle<bool>(() async {
      await habitDatasource.clearHabitsProgress();
      return Result.success(true);
    });
  }

  @override
  Future<Result<HabitEntity>> resetHabitProgress(HabitEntity habit, int index) {
    return _handle<HabitEntity>(() async {
      final result = await habitDatasource.resetHabitProgress(
        HabitModel.fromEntity(habit),
        index,
      );
      return Result.success(result.toEntity());
    });
  }

  Future<Result<T>> _handle<T>(Function f) async {
    try {
      return await f();
    } on TypeError catch (_) {
      return Result.failure(const CorruptedDataFailure());
    } on DatabaseIndexError catch (_) {
      return Result.failure(const DatabaseFailure());
    } on DatabaseError catch (_) {
      return Result.failure(const DatabaseFailure());
    } catch (e) {
      return Result.failure(const Failure());
    }
  }
}
