import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/domain/repositories/reminder_repository.dart';
import 'package:habit_go/app/reminders/domain/usecases/fetch_reminders_usecase.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late ReminderRepository repository;
  late FetchRemindersUsecase usecase;

  setUp(() {
    repository = MockReminderRepository();
    usecase = FetchRemindersUsecaseImpl(repository: repository);
  });

  test('should return a list of ReminderEntity when repository succeeds',
      () async {
    when(() => repository.getReminders())
        .thenAnswer((_) async => Result.success([reminderEntity2]));

    final result = await usecase();

    expect(result.data, [reminderEntity2]);
    verify(() => repository.getReminders()).called(1);
  });
}
