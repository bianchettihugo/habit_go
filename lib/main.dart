import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/app_module.dart';
import 'package:habit_go/app/habits/data/models/habit_model.dart';
import 'package:habit_go/app/habits/habits_module.dart';
import 'package:habit_go/app/habits/presentation/state/habits_bloc.dart';
import 'package:habit_go/app/habits/presentation/state/habits_event.dart';
import 'package:habit_go/app/progress/data/models/progress_model.dart';
import 'package:habit_go/app/progress/presentation/state/progress_bloc.dart';
import 'package:habit_go/app/progress/presentation/state/progress_event.dart';
import 'package:habit_go/app/progress/progress_module.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_bloc.dart';
import 'package:habit_go/app/settings/presentation/state/settings_cubit.dart';
import 'package:habit_go/core/services/dependency/dependency_service.dart';
import 'package:habit_go/core/services/events/event_service.dart';
import 'package:habit_go/core/services/storage/storage_service.dart';
import 'package:habit_go/core/services/storage/storage_service_impl.dart';
import 'package:habit_go/habitgo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_builder/timer_builder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sp = await SharedPreferences.getInstance();
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [HabitModelSchema, ProgressModelSchema],
    directory: dir.path,
  );

  Dependency.register<Isar>(isar);
  Dependency.register<EventService>(EventService());
  Dependency.register<StorageService>(
    StorageServiceImpl(sharedPreferences: sp),
  );

  HabitsModule.init();
  ProgressModule.init();
  AppModule.init();

  runApp(const HabitGoApp());
}

class HabitGoApp extends StatelessWidget {
  const HabitGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return TimerBuilder.periodic(
      const Duration(days: 1),
      alignment: const Duration(days: 1),
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<HabitsBloc>(
            create: (BuildContext context) => Dependency.get<HabitsBloc>()
              ..add(HabitLoadEvent())
              ..add(HabitClearEvent()),
          ),
          BlocProvider<ProgressBloc>(
            lazy: false,
            create: (BuildContext context) => Dependency.get<ProgressBloc>()
              ..add(const ProgressLoadEvent())
              ..add(const ProgressResetEvent()),
          ),
          BlocProvider<RemindersBloc>(
            lazy: false,
            create: (BuildContext context) => Dependency.get<RemindersBloc>(),
          ),
          BlocProvider<SettingsCubit>(
            lazy: false,
            create: (BuildContext context) => Dependency.get<SettingsCubit>(),
          ),
        ],
        child: const HabitGo(),
      ),
    );
  }
}
