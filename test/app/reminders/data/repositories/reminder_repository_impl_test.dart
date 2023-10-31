import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/data/datasources/reminder_datasource.dart';
import 'package:habit_go/app/reminders/data/models/reminder_model.dart';
import 'package:habit_go/app/reminders/data/repositories/reminder_repository_impl.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';

class MockReminderDatasource extends Mock implements ReminderDatasource {}

void main() {
  late ReminderRepositoryImpl repository;
  late ReminderDatasource datasource;

  setUp(() {
    datasource = MockReminderDatasource();
    repository = ReminderRepositoryImpl(reminderDatasource: datasource);
  });

  test('should return success result when adding reminder', () async {
    final reminder = reminderEntity;
    final reminderModel = ReminderModel.fromEntity(reminder);
    when(() => datasource.addReminder(reminderModel))
        .thenAnswer((_) async => reminderModel);

    final result = await repository.addReminder(reminder);

    expect(result, equals(Result.success(reminder)));
    verify(() => datasource.addReminder(reminderModel)).called(1);
  });

  test('should return failure result when adding reminder fails', () async {
    final reminder = reminderEntity;
    final reminderModel = ReminderModel.fromEntity(reminder);
    when(() => datasource.addReminder(reminderModel)).thenThrow(Exception());

    final result = await repository.addReminder(reminder);

    expect(result, equals(Result.failure(const Failure())));
    verify(() => datasource.addReminder(reminderModel)).called(1);
  });

  test('should return success result when deleting reminder', () async {
    final reminder = reminderEntity;
    final reminderModel = ReminderModel.fromEntity(reminder);
    when(() => datasource.deleteReminder(reminderModel))
        .thenAnswer((_) async => reminderModel);

    final result = await repository.deleteReminder(reminder);

    expect(result, equals(Result.success(reminder)));
    verify(() => datasource.deleteReminder(reminderModel)).called(1);
  });

  test('should return failure result when deleting reminder fails', () async {
    final reminder = reminderEntity;
    final reminderModel = ReminderModel.fromEntity(reminder);
    when(() => datasource.deleteReminder(reminderModel)).thenThrow(Exception());

    final result = await repository.deleteReminder(reminder);

    expect(result, equals(Result.failure(const Failure())));
    verify(() => datasource.deleteReminder(reminderModel)).called(1);
  });

  test('should return success result with reminders when getting reminders',
      () async {
    final reminders = [
      ReminderModel(
        id: 0,
        time: DateTime(2021, 11, 11),
        title: 'title',
      ),
      ReminderModel(
        id: 1,
        time: DateTime(2021, 11, 11),
        title: 'title',
      ),
    ];
    when(() => datasource.getReminders()).thenAnswer((_) async => reminders);

    final result = await repository.getReminders();

    expect(
      result.data![0],
      reminderEntity.copyWith(id: 0),
    );
    expect(
      result.data![1],
      reminderEntity.copyWith(id: 1),
    );
    verify(() => datasource.getReminders()).called(1);
  });

  test('should return failure result when getting empty reminders', () async {
    final reminders = <ReminderModel>[];
    when(() => datasource.getReminders()).thenAnswer((_) async => reminders);

    final result = await repository.getReminders();

    expect(result, equals(Result.failure(const NoDataFailure())));
    verify(() => datasource.getReminders()).called(1);
  });

  test('should return failure result when getting reminders fails', () async {
    when(() => datasource.getReminders()).thenThrow(Exception());

    final result = await repository.getReminders();

    expect(result, equals(Result.failure(const Failure())));
    verify(() => datasource.getReminders()).called(1);
  });

  test('should return success result when function returns a value', () async {
    when(() => datasource.addReminder(reminderModel2))
        .thenAnswer((_) async => reminderModel2);

    final result = await repository.addReminder(reminderEntity2);

    expect(result, equals(Result.success(reminderEntity2)));
  });

  test('should return failure result when function throws an exception',
      () async {
    when(() => datasource.addReminder(reminderModel2)).thenThrow(Exception());

    final result = await repository.addReminder(reminderEntity2);

    expect(result, equals(Result.failure(const Failure())));
  });

  test('should return failure result when function returns a RangeError',
      () async {
    when(() => datasource.addReminder(reminderModel2))
        .thenThrow(RangeError('test'));

    final result = await repository.addReminder(reminderEntity2);

    expect(result, equals(Result.failure(const CorruptedDataFailure())));
  });

  test(
      'should return failure result when function returns a DatabaseIndexError',
      () async {
    when(() => datasource.addReminder(reminderModel2))
        .thenThrow(DatabaseIndexError());

    final result = await repository.addReminder(reminderEntity2);

    expect(result, equals(Result.failure(const DatabaseFailure())));
  });

  test('should return failure result when function returns a DatabaseError',
      () async {
    when(() => datasource.addReminder(reminderModel2))
        .thenThrow(DatabaseError(''));

    final result = await repository.addReminder(reminderEntity2);

    expect(result, equals(Result.failure(const DatabaseFailure())));
  });
}
