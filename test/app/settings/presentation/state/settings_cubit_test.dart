import 'package:bloc_test/bloc_test.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';
import 'package:habit_go/app/settings/presentation/state/settings_cubit.dart';

void main() {
  const themeMode = AppTheme.dark;
  const completeAnimations = true;
  const appAnimations = false;
  const notifications = true;

  const settingsEntity = SettingsEntity(
    themeMode: themeMode,
    completeAnimations: completeAnimations,
    appAnimations: appAnimations,
    notifications: notifications,
  );

  blocTest<SettingsCubit, SettingsEntity>(
    'settings/presentation/state - emits the correct state when updateTheme is called',
    build: () => SettingsCubit(settingsEntity),
    act: (cubit) => cubit.updateTheme(AppTheme.light),
    expect: () => [
      settingsEntity.copyWith(themeMode: AppTheme.light),
    ],
  );

  blocTest<SettingsCubit, SettingsEntity>(
    'settings/presentation/state - emits the correct state when updateCompleteAnimations is called',
    build: () => SettingsCubit(settingsEntity),
    act: (cubit) => cubit.updateCompleteAnimations(false),
    expect: () => [
      settingsEntity.copyWith(completeAnimations: false),
    ],
  );

  blocTest<SettingsCubit, SettingsEntity>(
    'settings/presentation/state - emits the correct state when updateAppAnimations is called',
    build: () => SettingsCubit(settingsEntity),
    act: (cubit) => cubit.updateAppAnimations(true),
    expect: () => [
      settingsEntity.copyWith(appAnimations: true),
    ],
  );

  blocTest<SettingsCubit, SettingsEntity>(
    'settings/presentation/state - emits the correct state when updateNotifications is called',
    build: () => SettingsCubit(settingsEntity),
    act: (cubit) => cubit.updateNotifications(false),
    expect: () => [
      settingsEntity.copyWith(notifications: false),
    ],
  );
}
