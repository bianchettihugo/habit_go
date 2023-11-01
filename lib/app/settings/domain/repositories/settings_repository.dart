import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class SettingsRepository {
  Future<Result<SettingsEntity>> getSettings();
  Future<Result<SettingsEntity>> saveSettings(SettingsEntity settings);
}
