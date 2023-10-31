import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/data/models/reminder_model.dart';

void main() {
  test('reminders/data/models - should convert to and from an entity', () {
    final model = ReminderModel(
      id: 1,
      title: 'Test Reminder',
      time: DateTime(2022, 1, 1, 12, 0),
      enabled: true,
    );

    final entity = model.toEntity();

    expect(entity.id, model.id);
    expect(entity.title, model.title);
    expect(entity.time, model.time);
    expect(entity.enabled, model.enabled);

    final fromEntity = ReminderModel.fromEntity(entity);

    expect(fromEntity.id, model.id);
    expect(fromEntity.title, model.title);
    expect(fromEntity.time, model.time);
    expect(fromEntity.enabled, model.enabled);
  });

  test('reminders/data/models - should have value equality', () {
    final model1 = ReminderModel(
      id: 1,
      title: 'Test Reminder',
      time: DateTime(2022, 1, 1, 12, 0),
      enabled: true,
    );

    final model2 = ReminderModel(
      id: 1,
      title: 'Test Reminder',
      time: DateTime(2022, 1, 1, 12, 0),
      enabled: true,
    );

    final model3 = ReminderModel(
      id: 2,
      title: 'Test Reminder 2',
      time: DateTime(2022, 1, 2, 12, 0),
      enabled: false,
    );

    expect(model1, equals(model2));
    expect(model1.hashCode, equals(model2.hashCode));

    expect(model1, isNot(equals(model3)));
    expect(model1.hashCode, isNot(equals(model3.hashCode)));
  });
}
