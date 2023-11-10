import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/domain/usecases/set_habit_reminders_usecase.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late SetHabitRemindersUsecaseImpl usecase;
  late MockReminderRepository mockRepository;

  setUp(() {
    mockRepository = MockReminderRepository();
    usecase = SetHabitRemindersUsecaseImpl(repository: mockRepository);
  });

  const habitId = 1;
  final reminders = [
    reminderEntity,
    reminderEntity2,
  ];

  test('reminders/domain/usecases - should set habit reminders', () async {
    when(
      () => mockRepository.setHabitReminders(
        habitId: habitId,
        reminders: reminders,
      ),
    ).thenAnswer((_) async => Result.success(reminders));

    final result = await usecase(habitId: habitId, reminders: reminders);

    expect(result.data, reminders);
    verify(
      () => mockRepository.setHabitReminders(
        habitId: habitId,
        reminders: reminders,
      ),
    );
    verifyNoMoreInteractions(mockRepository);
  });
}
