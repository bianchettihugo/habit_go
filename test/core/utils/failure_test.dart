// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/utils/failure.dart';

void main() {
  test('core/utils - should create failures', () async {
    final failure1 = Failure(message: 'message');
    final failure2 = Failure(message: 'message');

    expect(failure1, failure2);
    expect(failure1.hashCode, failure2.hashCode);
    expect(const DatabaseFailure(), isA<Failure>());
    expect(const CorruptedDataFailure(), isA<Failure>());
  });
}
