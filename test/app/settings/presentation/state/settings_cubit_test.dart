import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';
import 'package:habit_go/app/settings/domain/usecases/get_settings_usecase.dart';
import 'package:habit_go/app/settings/domain/usecases/save_settings_usecase.dart';
import 'package:habit_go/app/settings/presentation/state/settings_cubit.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  const settingsEntity = SettingsEntity();

  late GetSettingsUsecase getSettingsUsecase;
  late SaveSettingsUsecase saveSettingsUsecase;

  setUp(() {
    getSettingsUsecase = MockGetSettingsUsecase();
    saveSettingsUsecase = MockSaveSettingsUsecase();
  });

  test('settings/presentation/state - initial state is correct', () {
    expect(
      SettingsCubit(
        getSettingsUsecase: getSettingsUsecase,
        saveSettingsUsecase: saveSettingsUsecase,
      ).state,
      equals(const SettingsEntity()),
    );
  });

  blocTest<SettingsCubit, SettingsEntity>(
    'settings/presentation/state - emits the correct state when getSettings is called',
    build: () {
      when(() => getSettingsUsecase()).thenAnswer(
        (_) async => Result.success(const SettingsEntity()),
      );
      return SettingsCubit(
        getSettingsUsecase: getSettingsUsecase,
        saveSettingsUsecase: saveSettingsUsecase,
      );
    },
    act: (cubit) => cubit.getSettings(),
    expect: () => [
      const SettingsEntity(),
    ],
  );

  blocTest<SettingsCubit, SettingsEntity>(
    'settings/presentation/state - emits the same state when getSettings returns a failure',
    build: () {
      when(() => getSettingsUsecase()).thenAnswer(
        (_) async => Result.failure(const Failure()),
      );
      return SettingsCubit(
        getSettingsUsecase: getSettingsUsecase,
        saveSettingsUsecase: saveSettingsUsecase,
      );
    },
    act: (cubit) => cubit.getSettings(),
    expect: () => [],
  );

  blocTest<SettingsCubit, SettingsEntity>(
    'settings/presentation/state - emits the correct state when updateTheme is called',
    build: () {
      when(
        () => saveSettingsUsecase(
          settingsEntity.copyWith(themeMode: AppTheme.light),
        ),
      ).thenAnswer(
        (_) async => Result.success(
          settingsEntity.copyWith(themeMode: AppTheme.light),
        ),
      );
      return SettingsCubit(
        getSettingsUsecase: getSettingsUsecase,
        saveSettingsUsecase: saveSettingsUsecase,
      );
    },
    act: (cubit) => cubit.updateTheme(AppTheme.light),
    expect: () => [
      settingsEntity.copyWith(themeMode: AppTheme.light),
    ],
    verify: (_) {
      verify(
        () => saveSettingsUsecase(
          settingsEntity.copyWith(themeMode: AppTheme.light),
        ),
      ).called(1);
    },
  );

  blocTest<SettingsCubit, SettingsEntity>(
    'settings/presentation/state - emits the correct state when updateCompleteAnimations is called',
    build: () {
      when(
        () => saveSettingsUsecase(
          settingsEntity.copyWith(completeAnimations: false),
        ),
      ).thenAnswer(
        (_) async => Result.success(
          settingsEntity.copyWith(completeAnimations: false),
        ),
      );
      return SettingsCubit(
        getSettingsUsecase: getSettingsUsecase,
        saveSettingsUsecase: saveSettingsUsecase,
      );
    },
    act: (cubit) => cubit.updateCompleteAnimations(false),
    expect: () => [
      settingsEntity.copyWith(completeAnimations: false),
    ],
    verify: (_) {
      verify(
        () => saveSettingsUsecase(
          settingsEntity.copyWith(completeAnimations: false),
        ),
      ).called(1);
    },
  );

  blocTest<SettingsCubit, SettingsEntity>(
    'settings/presentation/state - emits the correct state when updateAppAnimations is called',
    build: () {
      when(
        () => saveSettingsUsecase(
          settingsEntity.copyWith(appAnimations: true),
        ),
      ).thenAnswer(
        (_) async => Result.success(
          settingsEntity.copyWith(appAnimations: true),
        ),
      );
      return SettingsCubit(
        getSettingsUsecase: getSettingsUsecase,
        saveSettingsUsecase: saveSettingsUsecase,
      );
    },
    act: (cubit) => cubit.updateAppAnimations(true),
    expect: () => [
      settingsEntity.copyWith(appAnimations: true),
    ],
    verify: (_) {
      verify(
        () => saveSettingsUsecase(settingsEntity.copyWith(appAnimations: true)),
      ).called(1);
    },
  );

  blocTest<SettingsCubit, SettingsEntity>(
    'settings/presentation/state - emits the correct state when updateNotifications is called',
    build: () {
      when(
        () => saveSettingsUsecase(
          settingsEntity.copyWith(notifications: false),
        ),
      ).thenAnswer(
        (_) async => Result.success(
          settingsEntity.copyWith(notifications: false),
        ),
      );
      return SettingsCubit(
        getSettingsUsecase: getSettingsUsecase,
        saveSettingsUsecase: saveSettingsUsecase,
      );
    },
    act: (cubit) => cubit.updateNotifications(false),
    expect: () => [
      settingsEntity.copyWith(notifications: false),
    ],
    verify: (_) {
      verify(
        () => saveSettingsUsecase(
          settingsEntity.copyWith(notifications: false),
        ),
      ).called(1);
    },
  );
}
