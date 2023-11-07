import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';
import 'package:habit_go/app/settings/domain/repositories/settings_repository.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class GetSettingsUsecase {
  Future<Result<SettingsEntity>> call();
}

class GetSettingsUsecaseImpl extends GetSettingsUsecase {
  final SettingsRepository _repository;

  GetSettingsUsecaseImpl({required SettingsRepository repository})
      : _repository = repository;

  @override
  Future<Result<SettingsEntity>> call() async {
    return _repository.getSettings();
  }
}
