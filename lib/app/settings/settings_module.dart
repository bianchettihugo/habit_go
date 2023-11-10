// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:habit_go/app/settings/data/datasources/settings_datasource.dart';
import 'package:habit_go/app/settings/data/datasources/settings_datasource.local.dart';
import 'package:habit_go/app/settings/data/repositories/settings_repository_impl.dart';
import 'package:habit_go/app/settings/domain/repositories/settings_repository.dart';
import 'package:habit_go/app/settings/domain/usecases/get_settings_usecase.dart';
import 'package:habit_go/app/settings/domain/usecases/save_settings_usecase.dart';
import 'package:habit_go/app/settings/presentation/state/settings_cubit.dart';
import 'package:habit_go/core/services/dependency/dependency_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModule {
  static void init() {
    Dependency.register<SettingsDatasource>(
      LocalSettingsDatasource(
        sharedPreferences: Dependency.get<SharedPreferences>(),
      ),
    );

    Dependency.register<SettingsRepository>(
      SettingsRepositoryImpl(
        settingsDatasource: Dependency.get<SettingsDatasource>(),
      ),
    );

    Dependency.register<GetSettingsUsecase>(
      GetSettingsUsecaseImpl(
        repository: Dependency.get<SettingsRepository>(),
      ),
    );

    Dependency.register<SaveSettingsUsecase>(
      SaveSettingsUsecaseImpl(
        repository: Dependency.get<SettingsRepository>(),
      ),
    );

    Dependency.registerLazy(
      () => SettingsCubit(
        getSettingsUsecase: Dependency.get<GetSettingsUsecase>(),
        saveSettingsUsecase: Dependency.get<SaveSettingsUsecase>(),
      ),
    );

    if (kDebugMode) print('\x1B[36m-==== SETTINGS MODULE INITIALIZED ====-');
  }
}
