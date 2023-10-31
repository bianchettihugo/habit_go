import 'package:flutter/material.dart';
import 'package:habit_go/core/themes/theme_colors.dart';

class Extensions {}

extension BCExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ThemeColors get themeColors =>
      Theme.of(this).extension<ThemeColors>() ?? const ThemeColors();

  TextTheme get text => Theme.of(this).textTheme;
}

extension IntExtensions on int {
  int get getDay {
    final today = DateTime.now();
    final firstDayOfTheweek = today.subtract(
      Duration(days: today.weekday - 1),
    );
    return firstDayOfTheweek.add(Duration(days: this)).day;
  }
}
