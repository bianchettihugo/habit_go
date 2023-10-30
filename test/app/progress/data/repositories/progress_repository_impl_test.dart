import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/data/datasources/progress_datasource.dart';
import 'package:habit_go/app/progress/data/repositories/progress_repository_impl.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late ProgressDatasource datasource;
  late ProgressRepository repository;

  setUpAll(() {
    datasource = MockProgressDatasource();
    repository = ProgressRepositoryImpl(progressDatasource: datasource);
  });

  test('progress/data/repositories - should create a progress', () async {
    when(() => datasource.saveProgress(progressModel)).thenAnswer(
      (invocation) async => progressModel,
    );
    final result = await repository.saveProgress(progressEntity);
    expect(result, Result.success(progressEntity));
    verify(() => datasource.saveProgress(progressModel)).called(1);
  });

  test('progress/data/repositories - should get the progress', () async {
    when(() => datasource.getProgress()).thenAnswer(
      (invocation) async => progressModel,
    );
    final result = await repository.getProgress();
    expect(result.data, progressEntity);
    verify(() => datasource.getProgress()).called(1);
  });

  test(
      'progress/data/repositories - should return a NoDataFailure when there is no progress',
      () async {
    when(() => datasource.getProgress()).thenAnswer(
      (invocation) async => null,
    );
    final result = await repository.getProgress();
    expect(result, Result.failure(const NoDataFailure()));
    verify(() => datasource.getProgress()).called(1);
  });

  test('progress/data/repositories - should reset the progress', () async {
    when(() => datasource.resetProgress()).thenAnswer(
      (invocation) async => progressModel,
    );
    final result = await repository.resetProgress();
    expect(result, Result.success(progressEntity));
    verify(() => datasource.resetProgress()).called(1);
  });

  test('progress/data/repositories - should handle no data failure', () async {
    when(() => datasource.resetProgress()).thenThrow(RangeError(''));
    final result = await repository.resetProgress();
    expect(result, Result.failure(const CorruptedDataFailure()));
    verify(() => datasource.resetProgress()).called(1);
  });

  test('progress/data/repositories - should handle database failure', () async {
    when(() => datasource.resetProgress()).thenThrow(DatabaseError(''));
    final result = await repository.resetProgress();
    expect(result, Result.failure(const DatabaseFailure()));
    verify(() => datasource.resetProgress()).called(1);
  });

  test('progress/data/repositories - should handle database index failure',
      () async {
    when(() => datasource.resetProgress()).thenThrow(DatabaseIndexError());
    final result = await repository.resetProgress();
    expect(result, Result.failure(const DatabaseFailure()));
    verify(() => datasource.resetProgress()).called(1);
  });

  test('progress/data/repositories - should handle others failures', () async {
    when(() => datasource.resetProgress()).thenThrow(Exception(''));
    final result = await repository.resetProgress();
    expect(result, Result.failure(const Failure()));
    verify(() => datasource.resetProgress()).called(1);
  });
}
