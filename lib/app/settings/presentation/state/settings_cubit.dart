import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';
import 'package:habit_go/app/settings/domain/usecases/get_settings_usecase.dart';
import 'package:habit_go/app/settings/domain/usecases/save_settings_usecase.dart';

class SettingsCubit extends Cubit<SettingsEntity> {
  final GetSettingsUsecase _getSettings;
  final SaveSettingsUsecase _saveSettings;

  SettingsCubit({
    required GetSettingsUsecase getSettingsUsecase,
    required SaveSettingsUsecase saveSettingsUsecase,
  })  : _getSettings = getSettingsUsecase,
        _saveSettings = saveSettingsUsecase,
        super(const SettingsEntity());

  Future<void> getSettings() async {
    final result = await _getSettings();

    result.when(
      success: emit,
      failure: (failure) {},
    );
  }

  void updateTheme(AppTheme themeMode) {
    _saveSettings(state.copyWith(themeMode: themeMode));
    emit(state.copyWith(themeMode: themeMode));
  }

  void updateCompleteAnimations(bool completeAnimations) {
    _saveSettings(state.copyWith(completeAnimations: completeAnimations));
    emit(state.copyWith(completeAnimations: completeAnimations));
  }

  void updateAppAnimations(bool appAnimations) {
    _saveSettings(state.copyWith(appAnimations: appAnimations));
    emit(state.copyWith(appAnimations: appAnimations));
  }

  void updateNotifications(bool notifications) {
    _saveSettings(state.copyWith(notifications: notifications));
    emit(state.copyWith(notifications: notifications));
  }
}
