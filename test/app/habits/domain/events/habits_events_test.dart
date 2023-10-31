import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/events/habits_events.dart';

import '../../../../utils/data.dart';

void main() {
  test('habits/domain/events - habits events tests', () async {
    HabitSavedEvent();
    HabitDeleteEvent(entity: habitEntity);
    HabitActionEvent(day: 0);
    HabitResetProgressEvent(progress: 0, day: 0);
  });
}
