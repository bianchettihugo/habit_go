import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/presentation/state/habits_event.dart';

import '../../../../utils/data.dart';

void main() {
  test('habits/presentation/state - HabitUpdateEvent equality test', () async {
    final event = HabitUpdateEvent(habitDataUpdate);

    expect(event, HabitUpdateEvent(habitDataUpdate));
    expect(event.hashCode, HabitUpdateEvent(habitDataUpdate).hashCode);
  });
}
