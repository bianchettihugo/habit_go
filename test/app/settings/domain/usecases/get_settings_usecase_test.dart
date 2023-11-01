import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/settings/domain/repositories/settings_repository.dart';
import 'package:habit_go/app/settings/domain/usecases/get_settings_usecase.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late SettingsRepository repository;
  late GetSettingsUsecase usecase;

  setUp(() {
    repository = MockSettingsRepository();
    usecase = GetSettingsUsecaseImpl(repository: repository);
  });

  test(
      'settings/domain/usecases - should return a SettingsEntity when repository succeeds',
      () async {
    when(() => repository.getSettings())
        .thenAnswer((_) async => Result.success(settingsEntity));

    final result = await usecase();

    expect(result.data, settingsEntity);
    verify(() => repository.getSettings()).called(1);
  });
}
