import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/domain/repositories/reminder_repository.dart';
import 'package:habit_go/app/reminders/domain/usecases/fetch_reminders_by_habit_id_usecase.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';

class MockReminderRepository extends Mock implements ReminderRepository {}

void main() {
  late FetchRemindersByHabitIdUsecase usecase;
  late ReminderRepository repository;

  setUp(() {
    repository = MockReminderRepository();
    usecase = FetchRemindersByHabitIdUsecaseImpl(repository: repository);
  });

  const id = 1;

  test(
      'reminders/domain/usecases - should return a list of ReminderEntity from the repository',
      () async {
    final reminders = [reminderEntity];
    when(() => repository.getReminders(id))
        .thenAnswer((_) async => Result.success(reminders));

    final result = await usecase(id);

    expect(result.isSuccess, true);
    expect(result.data, reminders);
    verify(() => repository.getReminders(id)).called(1);
  });

  test(
      'reminders/domain/usecases - should return an InvalidDataFailure when id is negative',
      () async {
    const id = -1;

    final result = await usecase(id);

    expect(result.isSuccess, false);
    expect(result.error, const InvalidDataFailure());
    verifyNever(() => repository.getReminders(id));
  });
}
