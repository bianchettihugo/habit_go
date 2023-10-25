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
  });
}
