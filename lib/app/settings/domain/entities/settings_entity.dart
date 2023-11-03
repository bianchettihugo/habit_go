enum AppTheme implements Comparable<AppTheme> {
  light(id: 0),
  dark(id: 1),
  system(id: 2);

  const AppTheme({
    required this.id,
  });

  static AppTheme fromId(int id) {
    switch (id) {
      case 0:
        return AppTheme.light;
      case 1:
        return AppTheme.dark;
      case 2:
        return AppTheme.system;
      default:
        return AppTheme.light;
    }
  }

  final int id;

  @override
  int compareTo(AppTheme other) => id - other.id;
}

class SettingsEntity {
  final AppTheme themeMode;
  final bool completeAnimations;
  final bool appAnimations;
  final bool notifications;

  const SettingsEntity({
    this.themeMode = AppTheme.light,
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
    AppTheme? themeMode,
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
