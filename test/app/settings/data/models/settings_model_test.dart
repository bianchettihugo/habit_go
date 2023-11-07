// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/settings/data/models/settings_model.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';

void main() {
  test('settings/data/models - should convert from entity correctly', () {
    const entity = SettingsEntity(
      themeMode: ThemeMode.light,
      completeAnimations: false,
      appAnimations: true,
      notifications: true,
    );

    final model = SettingsModel.fromEntity(entity);

    expect(model.themeMode, 0);
    expect(model.completeAnimations, false);
    expect(model.appAnimations, true);
    expect(model.notifications, true);
  });

  test('settings/data/models - should convert to entity correctly', () {
    const model = SettingsModel(
      themeMode: 1,
      completeAnimations: true,
      appAnimations: false,
      notifications: true,
    );

    final entity = model.toEntity();

    expect(entity.themeMode, ThemeMode.dark);
    expect(entity.completeAnimations, true);
    expect(entity.appAnimations, false);
    expect(entity.notifications, true);
  });

  test(
      'settings/data/models - should be equal to another instance with the same properties',
      () {
    final model1 = SettingsModel(
      themeMode: 0,
      completeAnimations: true,
      appAnimations: true,
      notifications: false,
    );

    final model2 = SettingsModel(
      themeMode: 0,
      completeAnimations: true,
      appAnimations: true,
      notifications: false,
    );

    expect(model1, model2);
    expect(model1.hashCode, model2.hashCode);
  });
}
