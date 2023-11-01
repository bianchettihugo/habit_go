import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';
import 'package:habit_go/app/settings/domain/repositories/settings_repository.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class SaveSettingsUsecase {
  Future<Result<SettingsEntity>> call(SettingsEntity settings);
}

class SaveSettingsUsecaseImpl extends SaveSettingsUsecase {
  final SettingsRepository _repository;

  SaveSettingsUsecaseImpl({required SettingsRepository repository})
      : _repository = repository;

  @override
  Future<Result<SettingsEntity>> call(SettingsEntity settings) async {
    return _repository.saveSettings(settings);
  }
}
