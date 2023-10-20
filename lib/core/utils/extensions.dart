import 'package:flutter/material.dart';
import 'package:habit_go/core/themes/theme_colors.dart';

class Extensions {}

extension BCExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  ThemeColors get themeColors =>
      Theme.of(this).extension<ThemeColors>() ?? const ThemeColors();

  TextTheme get text => Theme.of(this).textTheme;
}
