// ignore_for_file: prefer_const_declarations

import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/settings/data/datasources/settings_datasource.dart';
import 'package:habit_go/app/settings/data/repositories/settings_repository_impl.dart';

import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart' as data;

class MockSettingsDatasource extends Mock implements SettingsDatasource {}

void main() {
  late SettingsRepositoryImpl repository;
  late SettingsDatasource datasource;

  setUp(() {
    registerFallbackValue(data.settingsModel);
    datasource = MockSettingsDatasource();
    repository = SettingsRepositoryImpl(settingsDatasource: datasource);
  });

  group('settings/data/repositories - getSettings', () {
    test('should return settings entity when datasource returns settings model',
        () async {
      when(() => datasource.getSettings())
          .thenAnswer((_) async => data.settingsModel);

      final result = await repository.getSettings();

      expect(result, equals(Result.success(data.settingsEntity)));
      verify(() => datasource.getSettings()).called(1);
    });

    test('should return failure when datasource throws TypeError', () async {
      when(() => datasource.getSettings()).thenThrow(TypeError());

      final result = await repository.getSettings();

      expect(result, equals(Result.failure(const CorruptedDataFailure())));
      verify(() => datasource.getSettings()).called(1);
    });

    test('should return failure when datasource throws StateError', () async {
      when(() => datasource.getSettings()).thenThrow(StateError(''));

      final result = await repository.getSettings();

      expect(result, equals(Result.failure(const DatabaseFailure())));
      verify(() => datasource.getSettings()).called(1);
    });

    test('should return failure when datasource throws UnimplementedError',
        () async {
      when(() => datasource.getSettings()).thenThrow(UnimplementedError());

      final result = await repository.getSettings();

      expect(result, equals(Result.failure(const DatabaseFailure())));
      verify(() => datasource.getSettings()).called(1);
    });

    test('should return failure when datasource throws any other error',
        () async {
      when(() => datasource.getSettings()).thenThrow(Exception());

      final result = await repository.getSettings();

      expect(result, equals(Result.failure(const Failure())));
      verify(() => datasource.getSettings()).called(1);
    });
  });

  group('settings/data/repositories - saveSettings', () {
    test('should return settings entity when datasource saves settings model',
        () async {
      when(() => datasource.saveSettings(any()))
          .thenAnswer((_) async => data.settingsModel);

      final result = await repository.saveSettings(data.settingsEntity);

      expect(result, equals(Result.success(data.settingsEntity)));
      verify(() => datasource.saveSettings(data.settingsModel)).called(1);
    });

    test('should return failure when datasource throws TypeError', () async {
      when(() => datasource.saveSettings(any())).thenThrow(TypeError());

      final result = await repository.saveSettings(data.settingsEntity);

      expect(result, equals(Result.failure(const CorruptedDataFailure())));
      verify(() => datasource.saveSettings(data.settingsModel)).called(1);
    });

    test('should return failure when datasource throws StateError', () async {
      when(() => datasource.saveSettings(any())).thenThrow(StateError(''));

      final result = await repository.saveSettings(data.settingsEntity);

      expect(result, equals(Result.failure(const DatabaseFailure())));
      verify(() => datasource.saveSettings(data.settingsModel)).called(1);
    });

    test('should return failure when datasource throws UnimplementedError',
        () async {
      when(() => datasource.saveSettings(any()))
          .thenThrow(UnimplementedError());

      final result = await repository.saveSettings(data.settingsEntity);

      expect(result, equals(Result.failure(const DatabaseFailure())));
      verify(() => datasource.saveSettings(data.settingsModel)).called(1);
    });

    test('should return failure when datasource throws any other error',
        () async {
      when(() => datasource.saveSettings(any())).thenThrow(Exception());

      final result = await repository.saveSettings(data.settingsEntity);

      expect(result, equals(Result.failure(const Failure())));
      verify(() => datasource.saveSettings(data.settingsModel)).called(1);
    });
  });
}
