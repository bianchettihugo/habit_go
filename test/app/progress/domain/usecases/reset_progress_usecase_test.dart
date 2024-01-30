import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/app/progress/domain/usecases/reset_progress_usecase.dart';
import 'package:habit_go/core/services/storage/storage_service.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late ProgressRepository repository;
  late ResetProgressUsecaseImpl resetProgress;
  late StorageService storageService;

  setUp(() {
    repository = MockProgressRepository();
    storageService = MockStorageService();
    resetProgress = ResetProgressUsecaseImpl(
      repository: repository,
      storageService: storageService,
    );
  });

  test(
      'progress/domain/usecases - should return NoActionFailure if lastMonth and lastYear are the same as current month and year',
      () async {
    registerFallbackValue(0);
    when(() => storageService.getInt('lastMonth'))
        .thenReturn(DateTime.now().month);
    when(() => storageService.getInt('lastYear'))
        .thenReturn(DateTime.now().year);

    final result = await resetProgress();

    expect(result, Result.failure(const NoActionFailure()));
    verifyNever(() => storageService.setInt('lastMonth', any()));
    verifyNever(() => storageService.setInt('lastYear', any()));
    verifyNever(() => repository.resetProgress());
  });

  test(
      'progress/domain/usecases - should call resetProgress from repository if lastMonth and lastYear are not the same as current month and year',
      () async {
    registerFallbackValue(0);
    when(() => storageService.getInt('lastMonth'))
        .thenReturn(DateTime.now().month - 1);
    when(() => storageService.getInt('lastYear'))
        .thenReturn(DateTime.now().year);
    when(() => storageService.setInt('lastMonth', DateTime.now().month))
        .thenAnswer((invocation) async {});
    when(() => storageService.setInt('lastYear', DateTime.now().year))
        .thenAnswer((invocation) async {});

    when(() => repository.resetProgress()).thenAnswer(
      (invocation) async => Result.success(progressEntity),
    );

    final result = await resetProgress();

    expect(result.data, progressEntity);
    verify(() => storageService.setInt('lastMonth', any())).called(1);
    verify(() => storageService.setInt('lastYear', any())).called(1);
  });
}
