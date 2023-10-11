import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/app/progress/domain/usecases/Save_progress_usecase.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late ProgressRepository repository;
  late SaveProgressUsecase saveProgress;

  setUpAll(() {
    repository = MockProgressRepository();
    saveProgress = SaveProgressUsecaseImpl(repository: repository);
  });

  test('progress/domain/usecases - should call save progress from repository',
      () async {
    when(() => repository.saveProgress(progressEntity)).thenAnswer(
      (invocation) async => Result.success(progressEntity),
    );

    final result = await saveProgress(progress: progressEntity);
    expect(result.data, progressEntity);
  });
}
