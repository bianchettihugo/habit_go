import 'package:habit_go/app/habits/data/models/habit_model.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/progress/data/models/progress_model.dart';
import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/app/reminders/data/models/reminder_model.dart';
import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/settings/data/models/settings_model.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';

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

final habitEntity2 = HabitEntity(
  id: 0,
  title: 'title',
  icon: 'clipboard',
  color: 'primary',
  repeat: 4,
  progress: [1, 1, 1, 1, 1, 1, 1],
  originalProgress: [1, 1, 1, 1, 1, 1, 1],
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

final habitDataUpdate = {
  'result': 'update',
  'id': 0,
  'name': 'title',
  'repeat': 5,
  'days': [1, 1, 1, 1, 1, 1, 1],
  'notify': true,
  'type': {
    'icon': 'clipboard',
    'color': 'primary',
  },
  'oldRepeat': 4,
  'oldProgress': [1, 1, 1, 1, 1, 1, 1],
};

final habitDataUpdate2 = {
  'result': 'update',
  'id': 0,
  'name': 'title',
  'repeat': 5,
  'days': [1, 1, 1, 1, 1, 1, 1],
  'notify': false,
  'type': {
    'icon': 'clipboard',
    'color': 'primary',
  },
  'oldRepeat': 4,
  'oldProgress': [1, 1, 1, 1, 1, 1, 1],
};

final habitDataCreate = {
  'result': 'create',
  'name': 'title',
  'repeat': 5,
  'days': [0, 0, 0, 0, 0, 0, -1],
  'notify': true,
  'type': {
    'icon': 'clipboard',
    'color': 'primary',
  },
};
final habitDataCreate2 = {
  'result': 'create',
  'name': 'title',
  'repeat': 5,
  'days': [0, 0, 0, 0, 0, 0, -1],
  'notify': false,
  'type': {
    'icon': 'clipboard',
    'color': 'primary',
  },
};

final progressModel = ProgressModel(
  doneActions: [2, 1],
  totalActions: [3, 3],
);

final progressModel2 = ProgressModel(
  doneActions: List.generate(31, (index) => 0),
  totalActions: List.generate(7, (index) => 1),
);

const progressEntity = ProgressEntity(
  doneActions: [2, 1],
  totalActions: [3, 3],
);

final reminderEntity = ReminderEntity(
  time: DateTime(2021, 11, 11),
  title: 'title',
);

final reminderModel = ReminderModel(
  time: DateTime(2021, 11, 11),
  title: 'title',
);

final reminderEntity2 = ReminderEntity(
  id: 0,
  time: DateTime(2021, 11, 11),
  title: 'title',
);

final reminderModel2 = ReminderModel(
  id: 0,
  time: DateTime(2021, 11, 11),
  title: 'title',
);

const settingsEntity = SettingsEntity(
  themeMode: AppTheme.light,
  completeAnimations: true,
  appAnimations: true,
  notifications: true,
);

const settingsModel = SettingsModel(
  themeMode: 0,
  completeAnimations: true,
  appAnimations: true,
  notifications: true,
);
