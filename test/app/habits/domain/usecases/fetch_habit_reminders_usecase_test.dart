// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/events/habits_events.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habit_reminders_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late FetchHabitReminderUsecaseImpl usecase;
  late MockEventService mockEventService;

  setUp(() {
    mockEventService = MockEventService();
    usecase = FetchHabitReminderUsecaseImpl(eventService: mockEventService);
  });

  test(
      'should return a list of DateTimes when the call to the EventService is successful',
      () async {
    const habitId = 1;
    final date = DateTime.now();
    final expected = [date];
    when(
      () => mockEventService.addAndWait<List<DateTime>>(
        HabitRemindersRequestEvent(habitId: habitId),
      ),
    ).thenAnswer((_) async => expected);

    final result = await usecase.call(habitId: habitId);

    expect(result.data, [date]);
    verify(
      () => mockEventService.addAndWait<List<DateTime>>(
        HabitRemindersRequestEvent(habitId: habitId),
      ),
    );
    verifyNoMoreInteractions(mockEventService);
  });
}
