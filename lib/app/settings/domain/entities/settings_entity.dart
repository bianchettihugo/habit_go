enum ThemeMode { light, dark, system }

class SettingsEntity {
  final ThemeMode themeMode;
  final bool completeAnimations;
  final bool appAnimations;
  final bool notifications;

  const SettingsEntity({
    this.themeMode = ThemeMode.light,
    this.completeAnimations = true,
    this.appAnimations = true,
    this.notifications = true,
  });

  @override
  bool operator ==(covariant SettingsEntity other) {
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

  SettingsEntity copyWith({
    ThemeMode? themeMode,
    bool? completeAnimations,
    bool? appAnimations,
    bool? notifications,
  }) {
    return SettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      completeAnimations: completeAnimations ?? this.completeAnimations,
      appAnimations: appAnimations ?? this.appAnimations,
      notifications: notifications ?? this.notifications,
    );
  }
}
