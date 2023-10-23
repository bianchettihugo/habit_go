import 'package:habit_go/app/habits/data/models/habit_model.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/progress/data/models/progress_model.dart';
import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';

final habitModel = HabitModel(
  id: 0,
  title: 'title',
  icon: 'ic-close',
  color: 'primary',
  repeat: 4,
  progress: [2, 3, 2],
  originalProgress: [2, 3, 2],
  reminder: true,
);

final habitEntity = HabitEntity(
  id: 0,
  title: 'title',
  icon: 'ic-close',
  color: 'primary',
  repeat: 4,
  progress: [2, 3, 2],
  originalProgress: [2, 3, 2],
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

final progressModel = ProgressModel(
  doneActions: [2, 1],
  totalActions: [3, 3],
);

final progressEntity = ProgressEntity(
  doneActions: [2, 1],
  totalActions: [3, 3],
);
