import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/utils/validators.dart';

void main() {
  test(
      'core/utils - equals returns true if the string is equal to the comparison',
      () {
    expect(Validators.equals('hello', 'hello'), isTrue);
  });

  test(
      'core/utils - equals returns false if the string is not equal to the comparison',
      () {
    expect(Validators.equals('hello', 'world'), isFalse);
  });

  test('core/utils - contains returns true if the string contains the seed',
      () {
    expect(Validators.contains('hello world', 'world'), isTrue);
  });

  test(
      'core/utils - contains returns false if the string does not contain the seed',
      () {
    expect(Validators.contains('hello world', 'foo'), isFalse);
  });

  test('core/utils - matches returns true if the string matches the pattern',
      () {
    expect(Validators.matches('hello world', r'world$'), isTrue);
  });

  test(
      'core/utils - matches returns false if the string does not match the pattern',
      () {
    expect(Validators.matches('hello world', r'foo$'), isFalse);
  });

  test('core/utils - isNumeric returns true if the string is numeric', () {
    expect(Validators.isNumeric('123'), isTrue);
  });

  test('core/utils - isNumeric returns false if the string is not numeric', () {
    expect(Validators.isNumeric('hello'), isFalse);
  });

  test('core/utils - isHour returns true if the string is a valid hour', () {
    expect(Validators.isHour('12:34'), isTrue);
  });

  test('core/utils - isHour returns false if the string is not a valid hour',
      () {
    expect(Validators.isHour('24:00'), isFalse);
  });

  test(
      'core/utils - isGreaterThan returns true if the string is greater than the number',
      () {
    expect(Validators.isGreaterThan('5', 3), isTrue);
  });

  test(
      'core/utils - isGreaterThan returns false if the string is not greater than the number',
      () {
    expect(Validators.isGreaterThan('2', 5), isFalse);
  });

  test('core/utils - isInt returns true if the string is an integer', () {
    expect(Validators.isInt('123'), isTrue);
  });

  test('core/utils - isInt returns false if the string is not an integer', () {
    expect(Validators.isInt('12.3'), isFalse);
  });

  test('core/utils - isFloat returns true if the string is a float', () {
    expect(Validators.isFloat('12.3'), isTrue);
  });

  test('core/utils - isFloat returns false if the string is not a float', () {
    expect(Validators.isFloat('hello'), isFalse);
  });

  test('core/utils - isLowercase returns true if the string is lowercase', () {
    expect(Validators.isLowercase('hello'), isTrue);
  });

  test('core/utils - isLowercase returns false if the string is not lowercase',
      () {
    expect(Validators.isLowercase('Hello'), isFalse);
  });

  test('core/utils - isUppercase returns true if the string is uppercase', () {
    expect(Validators.isUppercase('HELLO'), isTrue);
  });

  test('core/utils - isUppercase returns false if the string is not uppercase',
      () {
    expect(Validators.isUppercase('Hello'), isFalse);
  });

  test(
      'core/utils - isDivisibleBy returns false if the string is not divisible by the number',
      () {
    expect(Validators.isDivisibleBy('10', 3), isFalse);
  });

  test('core/utils - isNull returns true if the string is null or empty', () {
    expect(Validators.isNull(null), isTrue);
    expect(Validators.isNull(''), isTrue);
  });

  test('core/utils - isNull returns false if the string is not null or empty',
      () {
    expect(Validators.isNull('hello'), isFalse);
  });

  test('core/utils - isDate returns true if the string is a valid date', () {
    expect(Validators.isDate('2022-01-01'), isTrue);
  });

  test('core/utils - isDate returns false if the string is not a valid date',
      () {
    expect(Validators.isDate('hello'), isFalse);
  });

  test('core/utils - isAfter returns true if the string is after the date', () {
    expect(Validators.isAfter('2022-01-01', '2021-01-01'), isTrue);
    expect(Validators.isAfter('2022-01-01'), isFalse);
  });

  test('core/utils - isAfter returns false if the string is not after the date',
      () {
    expect(Validators.isAfter('2021-01-01', '2022-01-01'), isFalse);
  });

  test('core/utils - isBefore returns true if the string is before the date',
      () {
    expect(Validators.isBefore('2021-01-01', '2022-01-01'), isTrue);
    expect(Validators.isBefore('2022-01-01'), isTrue);
  });

  test(
      'core/utils - isBefore returns false if the string is not before the date',
      () {
    expect(Validators.isBefore('2022-01-01', '2021-01-01'), isFalse);
  });

  test('core/utils - isIn returns true if the string is in the list of values',
      () {
    expect(Validators.isIn('hello', ['hello', 'world']), isTrue);
  });

  test(
      'core/utils - isIn returns false if the string is not in the list of values',
      () {
    expect(Validators.isIn('foo', ['hello', 'world']), isFalse);
  });

  test(
      'core/utils - isLength returns true if the string has a length greater than or equal to the number',
      () {
    expect(Validators.isLength('hello', 3), isTrue);
  });

  test(
      'core/utils - isLength returns false if the string has a length less than the number',
      () {
    expect(Validators.isLength('hi', 3), isFalse);
  });
}
