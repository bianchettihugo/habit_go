import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/themes/theme_colors.dart';

void main() {
  testWidgets('core/themes - theme colors tests', (tester) async {
    const defaultColor = ThemeColors();
    defaultColor.lerp(null, 2);
    defaultColor.lerp(defaultColor, 2);
    defaultColor.copyWith(
      primary: Colors.black,
      cian: Colors.black,
      green: Colors.black,
      red: Colors.black,
      blue: Colors.black,
      yellow: Colors.black,
      pink: Colors.black,
      purple: Colors.black,
      orange: Colors.black,
      grey: Colors.black,
      red50: Colors.black,
      red75: Colors.black,
    );
    expect(defaultColor.copyWith(), const ThemeColors());
    expect(defaultColor.hashCode, const ThemeColors().hashCode);
  });
}
