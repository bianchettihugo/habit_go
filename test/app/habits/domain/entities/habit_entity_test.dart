import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';

import '../../../../utils/data.dart';

void main() {
  final entity = HabitEntity(
    id: 0,
    title: 'title',
    icon: 'ic-close',
    color: 'primary',
    repeat: 4,
    originalProgress: [2, 3, 2],
    progress: [2, 3, 2],
    reminder: true,
  );

  test('habits/domain/entities - should create a new entity', () async {
    expect(entity, habitEntity);
    expect(entity.hashCode, habitEntity.hashCode);
  });

  test('habits/domain/entities - should create a copy of an entity', () async {
    expect(entity.copyWith(), habitEntity);
    expect(
      entity.copyWith(color: 'yellow'),
      HabitEntity(
        id: 0,
        title: 'title',
        icon: 'ic-close',
        color: 'yellow',
        repeat: 4,
        progress: [2, 3, 2],
        originalProgress: [2, 3, 2],
        reminder: true,
      ),
    );
    expect(
      entity.copyWith(color: 'yellow', progress: [0, 0]),
      HabitEntity(
        id: 0,
        title: 'title',
        icon: 'ic-close',
        color: 'yellow',
        repeat: 4,
        progress: [0, 0],
        originalProgress: [0, 0],
        reminder: true,
      ),
    );
  });
}
