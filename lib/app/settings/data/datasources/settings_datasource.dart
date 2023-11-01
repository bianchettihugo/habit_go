import 'package:habit_go/app/settings/data/models/settings_model.dart';

abstract class SettingsDatasource {
  Future<SettingsModel> getSettings();
  Future<SettingsModel> saveSettings(SettingsModel settings);
}
