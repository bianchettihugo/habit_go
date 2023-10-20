// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class ThemeColors extends ThemeExtension<ThemeColors> {
  final Color primary;
  final Color cian;
  final Color green;
  final Color red;
  final Color blue;
  final Color yellow;
  final Color pink;
  final Color purple;
  final Color orange;
  final Color grey;
  final Color red50;
  final Color red75;

  const ThemeColors({
    this.primary = Colors.black,
    this.cian = Colors.black,
    this.green = Colors.black,
    this.red = Colors.black,
    this.blue = Colors.black,
    this.yellow = Colors.black,
    this.pink = Colors.black,
    this.purple = Colors.black,
    this.orange = Colors.black,
    this.grey = Colors.black,
    this.red50 = Colors.black,
    this.red75 = Colors.black,
  });

  @override
  ThemeColors lerp(ThemeColors? other, double t) {
    if (other is! ThemeColors) {
      return this;
    }
    return ThemeColors(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      cian: Color.lerp(cian, other.cian, t) ?? cian,
      green: Color.lerp(green, other.green, t) ?? green,
      red: Color.lerp(red, other.red, t) ?? red,
      blue: Color.lerp(blue, other.blue, t) ?? blue,
      yellow: Color.lerp(yellow, other.yellow, t) ?? yellow,
      pink: Color.lerp(pink, other.pink, t) ?? pink,
      purple: Color.lerp(purple, other.purple, t) ?? purple,
      orange: Color.lerp(orange, other.orange, t) ?? orange,
      grey: Color.lerp(grey, other.grey, t) ?? grey,
      red50: Color.lerp(red50, other.red50, t) ?? red50,
      red75: Color.lerp(red75, other.red75, t) ?? red75,
    );
  }

  @override
  ThemeColors copyWith({
    Color? primary,
    Color? cian,
    Color? green,
    Color? red,
    Color? blue,
    Color? yellow,
    Color? pink,
    Color? purple,
    Color? orange,
    Color? grey,
    Color? red50,
    Color? red75,
  }) {
    return ThemeColors(
      primary: primary ?? this.primary,
      cian: cian ?? this.cian,
      green: green ?? this.green,
      red: red ?? this.red,
      blue: blue ?? this.blue,
      yellow: yellow ?? this.yellow,
      pink: pink ?? this.pink,
      purple: purple ?? this.purple,
      orange: orange ?? this.orange,
      grey: grey ?? this.grey,
      red50: red50 ?? this.red50,
      red75: red75 ?? this.red75,
    );
  }

  @override
  bool operator ==(covariant ThemeColors other) {
    if (identical(this, other)) return true;

    return other.primary == primary &&
        other.cian == cian &&
        other.green == green &&
        other.red == red &&
        other.blue == blue &&
        other.yellow == yellow &&
        other.pink == pink &&
        other.purple == purple &&
        other.orange == orange &&
        other.grey == grey &&
        other.red50 == red50 &&
        other.red75 == red75;
  }

  @override
  int get hashCode {
    return primary.hashCode ^
        cian.hashCode ^
        green.hashCode ^
        red.hashCode ^
        blue.hashCode ^
        yellow.hashCode ^
        pink.hashCode ^
        purple.hashCode ^
        orange.hashCode ^
        grey.hashCode ^
        red50.hashCode ^
        red75.hashCode;
  }
}
