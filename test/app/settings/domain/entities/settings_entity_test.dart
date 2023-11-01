import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';

void main() {
  test('settings/domain/entities - test SettingsEntity equality', () {
    const settings1 = SettingsEntity(
      themeMode: ThemeMode.light,
      completeAnimations: true,
      appAnimations: true,
      notifications: true,
    );
    const settings2 = SettingsEntity(
      themeMode: ThemeMode.light,
      completeAnimations: true,
      appAnimations: true,
      notifications: true,
    );

    expect(settings1, equals(settings2));
    expect(settings1.hashCode, settings2.hashCode);
  });

  test(
      'settings/domain/entities - copyWith creates a new instance with the updated properties',
      () {
    const settings1 = SettingsEntity(
      themeMode: ThemeMode.light,
      completeAnimations: true,
      appAnimations: true,
      notifications: true,
    );
    settings1.copyWith();
    final settings2 = settings1.copyWith(
      themeMode: ThemeMode.dark,
      completeAnimations: false,
    );

    expect(settings1.themeMode, equals(ThemeMode.light));
    expect(settings1.completeAnimations, equals(true));
    expect(settings1.appAnimations, equals(true));
    expect(settings1.notifications, equals(true));

    expect(settings2.themeMode, equals(ThemeMode.dark));
    expect(settings2.completeAnimations, equals(false));
    expect(settings2.appAnimations, equals(true));
    expect(settings2.notifications, equals(true));
  });
}
