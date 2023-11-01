import 'package:habit_go/app/settings/data/datasources/settings_datasource.dart';
import 'package:habit_go/app/settings/data/models/settings_model.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';
import 'package:habit_go/app/settings/domain/repositories/settings_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsDatasource settingsDatasource;

  SettingsRepositoryImpl({required this.settingsDatasource});

  @override
  Future<Result<SettingsEntity>> getSettings() {
    return _handle<SettingsEntity>(() async {
      final result = await settingsDatasource.getSettings();
      return Result.success(result.toEntity());
    });
  }

  @override
  Future<Result<SettingsEntity>> saveSettings(SettingsEntity settings) {
    return _handle(() async {
      final sett = await settingsDatasource.saveSettings(
        SettingsModel.fromEntity(settings),
      );
      return Result.success(sett.toEntity());
    });
  }

  Future<Result<T>> _handle<T>(Function f) async {
    try {
      return await f();
    } on TypeError catch (_) {
      return Result.failure(const CorruptedDataFailure());
    } on StateError catch (_) {
      return Result.failure(const DatabaseFailure());
    } on UnimplementedError catch (_) {
      return Result.failure(const DatabaseFailure());
    } catch (e) {
      return Result.failure(const Failure());
    }
  }
}
