import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/app/progress/domain/usecases/get_progress_usecase.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late ProgressRepository repository;
  late GetProgressUsecase fetchProgress;

  setUpAll(() {
    repository = MockProgressRepository();
    fetchProgress = GetProgressUsecaseImpl(repository: repository);
  });

  test('progress/domain/usecases - should call get progress from repository',
      () async {
    when(() => repository.getProgress()).thenAnswer(
      (invocation) async => Result.success(progressEntity),
    );

    final result = await fetchProgress();
    expect(result.data, progressEntity);
  });
}
