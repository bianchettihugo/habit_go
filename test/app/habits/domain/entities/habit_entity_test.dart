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
    progress: [2, 3, 2],
    reminder: true,
  );

  testWidgets('habits/domain/entities - should create a new entity',
      (tester) async {
    expect(entity, habitEntity);
    expect(entity.hashCode, habitEntity.hashCode);
  });
}
