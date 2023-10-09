import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/data/models/habit_model.dart';

import '../../../../utils/data.dart';

void main() {
  final model = HabitModel(
    id: 0,
    title: 'title',
    icon: 'ic-close',
    color: 'primary',
    repeat: 4,
    progress: [2, 3, 2],
    reminder: true,
  );

  test('habits/data/models - should create a new model', () async {
    expect(model, habitModel);
    expect(model.hashCode, habitModel.hashCode);
  });

  test('habits/data/models - should create a new model from an entity',
      () async {
    expect(HabitModel.fromEntity(habitEntity), habitModel);
  });

  test('habits/data/models - should create an entity from a model', () async {
    expect(model.toEntity(), habitEntity);
  });
}
