import 'package:habit_go/app/reminders/data/datasources/reminder_datasource.dart';
import 'package:habit_go/app/reminders/data/models/reminder_model.dart';
import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/domain/repositories/reminder_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

class ReminderRepositoryImpl extends ReminderRepository {
  final ReminderDatasource reminderDatasource;

  ReminderRepositoryImpl({required this.reminderDatasource});

  @override
  Future<Result<ReminderEntity>> addReminder(ReminderEntity reminder) {
    return _handle<ReminderEntity>(() async {
      final result = await reminderDatasource.addReminder(
        ReminderModel.fromEntity(reminder),
      );
      return Result.success(result.toEntity());
    });
  }

  @override
  Future<Result<ReminderEntity>> deleteReminder(ReminderEntity reminder) {
    return _handle<ReminderEntity>(() async {
      final result = await reminderDatasource.deleteReminder(
        ReminderModel.fromEntity(reminder),
      );
      return Result.success(result.toEntity());
    });
  }

  @override
  Future<Result<List<ReminderEntity>>> getReminders([int? habitId]) {
    return _handle<List<ReminderEntity>>(() async {
      final result = await reminderDatasource.getReminders(habitId);
      if (result.isEmpty) {
        return Result.failure(const NoDataFailure());
      }
      return Result.success(result.map((e) => e.toEntity()).toList());
    });
  }

  @override
  Future<Result<List<ReminderEntity>>> setHabitReminders({
    required int habitId,
    required List<ReminderEntity> reminders,
  }) {
    return _handle<List<ReminderEntity>>(() async {
      final result = await reminderDatasource.setHabitReminders(
        habitId: habitId,
        reminders: reminders.map(ReminderModel.fromEntity).toList(),
      );
      return Result.success(result.map((e) => e.toEntity()).toList());
    });
  }

  Future<Result<T>> _handle<T>(Function f) async {
    try {
      return await f();
    } on RangeError catch (_) {
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
