import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';

class SettingsCubit extends Cubit<SettingsEntity> {
  SettingsCubit(super.initialState);

  void updateTheme(AppTheme themeMode) =>
      emit(state.copyWith(themeMode: themeMode));

  void updateCompleteAnimations(bool completeAnimations) =>
      emit(state.copyWith(completeAnimations: completeAnimations));

  void updateAppAnimations(bool appAnimations) =>
      emit(state.copyWith(appAnimations: appAnimations));

  void updateNotifications(bool notifications) =>
      emit(state.copyWith(notifications: notifications));
}
