import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';

class SettingsModel {
  final int themeMode;
  final bool completeAnimations;
  final bool appAnimations;
  final bool notifications;

  const SettingsModel({
    this.themeMode = 0,
    this.completeAnimations = true,
    this.appAnimations = true,
    this.notifications = true,
  });

  factory SettingsModel.fromEntity(SettingsEntity entity) {
    return SettingsModel(
      themeMode: entity.themeMode.id,
      completeAnimations: entity.completeAnimations,
      appAnimations: entity.appAnimations,
      notifications: entity.notifications,
    );
  }

  SettingsEntity toEntity() {
    return SettingsEntity(
      themeMode: AppTheme.fromId(themeMode),
      completeAnimations: completeAnimations,
      appAnimations: appAnimations,
      notifications: notifications,
    );
  }

  @override
  bool operator ==(covariant SettingsModel other) {
    if (identical(this, other)) return true;

    return other.themeMode == themeMode &&
        other.completeAnimations == completeAnimations &&
        other.appAnimations == appAnimations &&
        other.notifications == notifications;
  }

  @override
  int get hashCode {
    return themeMode.hashCode ^
        completeAnimations.hashCode ^
        appAnimations.hashCode ^
        notifications.hashCode;
  }
}
