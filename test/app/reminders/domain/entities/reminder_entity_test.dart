import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';

import '../../../../utils/data.dart';

void main() {
  final entity = ReminderEntity(
    time: DateTime(2021, 11, 11),
    title: 'title',
  );

  test('reminders/domain/entities - should create a new entity', () async {
    expect(entity, reminderEntity);
    expect(entity.hashCode, reminderEntity.hashCode);
  });

  test('reminders/domain/entities - should create a copy of an entity',
      () async {
    expect(entity.copyWith(), reminderEntity);
    expect(
      entity.copyWith(title: ''),
      ReminderEntity(
        time: DateTime(2021, 11, 11),
        title: '',
      ),
    );
    expect(
      entity.copyWith(
        time: DateTime(2021, 11, 10),
        title: '',
      ),
      ReminderEntity(
        time: DateTime(2021, 11, 10),
        title: '',
      ),
    );
  });
}
