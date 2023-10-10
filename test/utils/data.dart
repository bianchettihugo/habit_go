import 'package:habit_go/app/habits/data/models/habit_model.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';

final habitModel = HabitModel(
  id: 0,
  title: 'title',
  icon: 'ic-close',
  color: 'primary',
  repeat: 4,
  progress: [2, 3, 2],
  reminder: true,
);

final habitEntity = HabitEntity(
  id: 0,
  title: 'title',
  icon: 'ic-close',
  color: 'primary',
  repeat: 4,
  progress: [2, 3, 2],
  reminder: true,
);

final habitData1 = {
  'id': null,
  'name': 'title',
  'repeat': '4',
  'days': [2, 3, 2],
  'notify': true,
  'type': {
    'icon': 'ic-close',
    'color': 'primary',
  },
};

final habitData2 = {
  'id': '0',
  'name': 'title',
  'repeat': '4',
  'days': [2, 3, 2],
  'notify': true,
  'type': {
    'icon': 'ic-close',
    'color': 'primary',
  },
};
