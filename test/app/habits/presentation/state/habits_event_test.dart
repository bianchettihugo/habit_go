import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/presentation/state/habits_event.dart';

import '../../../../utils/data.dart';

void main() {
  test('habits/presentation/state - HabitUpdateEvent equality test', () async {
    final event = HabitUpdateEvent(habitDataUpdate);

    expect(event, HabitUpdateEvent(habitDataUpdate));
    expect(event.hashCode, HabitUpdateEvent(habitDataUpdate).hashCode);
    expect(event.props, HabitUpdateEvent(habitDataUpdate).props);
  });

  test('habits/presentation/state - HabitDeleteEvent equality test', () async {
    final event = HabitDeleteEvent(habitEntity2);

    expect(event, HabitDeleteEvent(habitEntity2));
    expect(event.hashCode, HabitDeleteEvent(habitEntity2).hashCode);
    expect(event.props, HabitDeleteEvent(habitEntity2).props);
  });

  test('habits/presentation/state - HabitProgressEvent equality test',
      () async {
    final event = HabitProgressEvent(index: 0, habit: habitEntity2);

    expect(event, HabitProgressEvent(index: 0, habit: habitEntity2));
    expect(
      event.hashCode,
      HabitProgressEvent(index: 0, habit: habitEntity2).hashCode,
    );
    expect(
      event.props,
      HabitProgressEvent(index: 0, habit: habitEntity2).props,
    );
  });

  test('habits/presentation/state - HabitResetEvent equality test', () async {
    final event = HabitResetEvent(habit: habitEntity2, index: 0);

    expect(event, HabitResetEvent(habit: habitEntity2, index: 0));
    expect(
      event.hashCode,
      HabitResetEvent(habit: habitEntity2, index: 0).hashCode,
    );
    expect(event.props, HabitResetEvent(habit: habitEntity2, index: 0).props);
  });

  test('habits/presentation/state - HabitAddEvent equality test', () async {
    final event = HabitAddEvent(habitData1);

    expect(event, HabitAddEvent(habitData1));
    expect(event.hashCode, HabitAddEvent(habitData1).hashCode);
    expect(event.props, HabitAddEvent(habitData1).props);
  });

  test('habits/presentation/state - HabitLoadEvent equality test', () async {
    final event = HabitLoadEvent();

    expect(event, HabitLoadEvent());
    expect(event.hashCode, HabitLoadEvent().hashCode);
    expect(event.props, HabitLoadEvent().props);
  });

  test('habits/presentation/state - HabitClearEvent equality test', () async {
    final event = HabitClearEvent();

    expect(event, HabitClearEvent());
    expect(event.hashCode, HabitClearEvent().hashCode);
    expect(event.props, HabitClearEvent().props);
  });
}
