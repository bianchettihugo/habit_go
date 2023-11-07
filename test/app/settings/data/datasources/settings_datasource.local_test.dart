import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/settings/data/datasources/settings_datasource.local.dart';
import 'package:habit_go/app/settings/data/models/settings_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/mocks.dart';

void main() {
  late LocalSettingsDatasource datasource;
  late SharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    datasource = LocalSettingsDatasource(sharedPreferences: sharedPreferences);
  });

  test('settings/data/datasources - should get the settings', () async {
    when(() => sharedPreferences.getInt('hab_themeMode')).thenReturn(1);
    when(() => sharedPreferences.getBool('hab_completeAnimations'))
        .thenReturn(false);
    when(() => sharedPreferences.getBool('hab_appAnimations')).thenReturn(true);
    when(() => sharedPreferences.getBool('hab_notifications'))
        .thenReturn(false);

    final result = await datasource.getSettings();

    expect(
      result,
      const SettingsModel(
        themeMode: 1,
        completeAnimations: false,
        appAnimations: true,
        notifications: false,
      ),
    );
  });

  test('settings/data/datasources - should save the settings', () async {
    when(() => sharedPreferences.setInt('hab_themeMode', 2))
        .thenAnswer((invocation) async => true);
    when(() => sharedPreferences.setBool('hab_completeAnimations', true))
        .thenAnswer((invocation) async => true);
    when(() => sharedPreferences.setBool('hab_appAnimations', false))
        .thenAnswer((invocation) async => true);
    when(() => sharedPreferences.setBool('hab_notifications', true))
        .thenAnswer((invocation) async => true);

    const settings = SettingsModel(
      themeMode: 2,
      completeAnimations: true,
      appAnimations: false,
      notifications: true,
    );

    await datasource.saveSettings(settings);

    verify(() => sharedPreferences.setInt('hab_themeMode', 2));
    verify(() => sharedPreferences.setBool('hab_completeAnimations', true));
    verify(() => sharedPreferences.setBool('hab_appAnimations', false));
    verify(() => sharedPreferences.setBool('hab_notifications', true));
  });
}
