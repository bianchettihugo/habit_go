// ignore_for_file: type_annotate_public_apis, parameter_assignments

class Validators {
  static final RegExp _numeric = RegExp(r'^-?[0-9]+$');
  static final RegExp _int = RegExp(r'^(?:-?(?:0|[1-9][0-9]*))$');
  static final RegExp _float =
      RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');

  static bool equals(String? str, comparison) {
    return str == comparison.toString();
  }

  static bool contains(String str, seed) {
    return str.contains(seed.toString());
  }

  static bool matches(String str, pattern) {
    final re = RegExp(pattern);
    return re.hasMatch(str);
  }

  static bool isNumeric(String str) {
    return _numeric.hasMatch(str);
  }

  static bool isHour(String str) {
    return RegExp(r'^(?:[01]?\d|2[0-3])(?::(?:[0-5]\d?)?)?$').hasMatch(str);
  }

  static bool isGreaterThan(String str, int n) {
    if (!isNumeric(str)) return false;

    final number = int.tryParse(str);
    if (number == null) return false;

    return number > n;
  }

  static bool isInt(String str) {
    return _int.hasMatch(str);
  }

  static bool isFloat(String str) {
    return _float.hasMatch(str);
  }

  static bool isLowercase(String str) {
    return str == str.toLowerCase();
  }

  static bool isUppercase(String str) {
    return str == str.toUpperCase();
  }

  static bool isDivisibleBy(String str, n) {
    try {
      return int.parse(str) % int.parse(n) == 0;
    } catch (e) {
      return false;
    }
  }

  static bool isNull(String? str) {
    return str == null || str.isEmpty;
  }

  static bool isDate(String str) {
    try {
      DateTime.parse(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  static bool isAfter(String? str, [date]) {
    if (date == null) {
      date = DateTime.now();
    } else if (isDate(date)) {
      date = DateTime.parse(date);
    } else {
      return false;
    }

    DateTime strDate;
    try {
      strDate = DateTime.parse(str!);
    } catch (e) {
      return false;
    }

    return strDate.isAfter(date);
  }

  static bool isBefore(String? str, [date]) {
    if (date == null) {
      date = DateTime.now();
    } else if (isDate(date)) {
      date = DateTime.parse(date);
    } else {
      return false;
    }

    DateTime strDate;
    try {
      strDate = DateTime.parse(str!);
    } catch (e) {
      return false;
    }

    return strDate.isBefore(date);
  }

  static bool? isIn(String? str, values) {
    if (values == null || values.length == 0) {
      return false;
    }

    if (values is List) {
      values = values.map((e) => e.toString()).toList();
    }

    return values.indexOf(str) >= 0;
  }

  static bool isLength(String? str, int i) {
    return str != null && str.length >= i;
  }
}
