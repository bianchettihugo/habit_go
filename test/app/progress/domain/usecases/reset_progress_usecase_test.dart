import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/app/progress/domain/usecases/Reset_progress_usecase.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late ProgressRepository repository;
  late ResetProgressUsecase resetProgress;

  setUpAll(() {
    repository = MockProgressRepository();
    resetProgress = ResetProgressUsecaseImpl(repository: repository);
  });

  test('progress/domain/usecases - should call reset progress from repository',
      () async {
    when(() => repository.resetProgress()).thenAnswer(
      (invocation) async => Result.success(progressEntity),
    );

    final result = await resetProgress();
    expect(result.data, progressEntity);
  });
}
