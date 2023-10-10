import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

void main() {
  test('core/utils - should check if result returns success', () async {
    final result = Result.success(true);
    expect(result.isSuccess, true);
  });

  test('core/utils - should return result data', () async {
    final result = Result.success(true);
    expect(result.error, null);
    expect(result.data, true);
  });

  test('core/utils - should return result error', () async {
    final result = Result.failure(const Failure(message: 'Error'));
    expect(result.data, null);
    expect(result.error, const Failure(message: 'Error'));
  });

  test('core/utils - should call success function when result returns success',
      () async {
    var count = 0;
    final result = Result.success(1);
    result.when(
      failure: (error) => count = 2,
      success: (success) => count = success,
    );
    expect(count, 1);
  });

  test('core/utils - should call error function when result returns error',
      () async {
    var count = 0;
    final result = Result.failure(const Failure(message: 'error'));
    result.when(
      failure: (error) => count = 2,
      success: (success) => count = success,
    );
    expect(count, 2);
  });

  test('core/utils - should check result equality', () async {
    final result = Result.success(true);
    final result2 = Result.success(true);

    expect(result, result2);
    expect(result.hashCode, result2.hashCode);
  });
}
