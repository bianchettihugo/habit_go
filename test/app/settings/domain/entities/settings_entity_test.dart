// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';

void main() {
  test('settings/domain/entities - test SettingsEntity equality', () {
    final settings1 = SettingsEntity(
      themeMode: ThemeMode.light,
      completeAnimations: true,
      appAnimations: true,
      notifications: true,
    );
    final settings2 = SettingsEntity(
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

  test('settings/domain/entities - enum test', () {
    const settings1 = ThemeMode.light;
    const settings2 = ThemeMode.dark;
    const settings3 = ThemeMode.system;
    settings1.compareTo(settings3);

    expect(settings1.id, 0);
    expect(settings2.id, 1);
    expect(settings3.id, 2);

    expect(ThemeMode.fromId(0), settings1);
    expect(ThemeMode.fromId(1), settings2);
    expect(ThemeMode.fromId(2), settings3);
    expect(ThemeMode.fromId(3), settings1);
  });
}
