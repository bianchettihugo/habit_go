import 'package:habit_go/app/settings/data/datasources/settings_datasource.dart';
import 'package:habit_go/app/settings/data/models/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSettingsDatasource extends SettingsDatasource {
  final SharedPreferences sharedPreferences;

  LocalSettingsDatasource({
    required this.sharedPreferences,
  });

  @override
  Future<SettingsModel> getSettings() async {
    return SettingsModel(
      themeMode: sharedPreferences.getInt('hab_themeMode') ?? 0,
      completeAnimations:
          sharedPreferences.getBool('hab_completeAnimations') ?? true,
      appAnimations: sharedPreferences.getBool('hab_appAnimations') ?? true,
      notifications: sharedPreferences.getBool('hab_notifications') ?? true,
    );
  }

  @override
  Future<SettingsModel> saveSettings(SettingsModel settings) async {
    await sharedPreferences.setInt('hab_themeMode', settings.themeMode);
    await sharedPreferences.setBool(
      'hab_completeAnimations',
      settings.completeAnimations,
    );
    await sharedPreferences.setBool(
      'hab_appAnimations',
      settings.appAnimations,
    );
    await sharedPreferences.setBool(
      'hab_notifications',
      settings.notifications,
    );
    return settings;
  }
}
