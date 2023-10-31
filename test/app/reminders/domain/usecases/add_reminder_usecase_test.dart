import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/domain/repositories/reminder_repository.dart';
import 'package:habit_go/app/reminders/domain/usecases/add_reminder_usecase.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late ReminderRepository repository;
  late AddReminderUsecase usecase;

  setUp(() {
    repository = MockReminderRepository();
    usecase = AddReminderUsecaseImpl(repository: repository);
  });

  test('should return a ReminderEntity when repository succeeds', () async {
    when(() => repository.addReminder(reminderEntity2))
        .thenAnswer((_) async => Result.success(reminderEntity2));

    final result = await usecase(reminderEntity2);

    expect(result.data, reminderEntity2);
    verify(() => repository.addReminder(reminderEntity2)).called(1);
  });
}
