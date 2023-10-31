import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/habits/data/models/habit_model.dart';
import 'package:habit_go/app/habits/habits_module.dart';
import 'package:habit_go/app/habits/presentation/pages/habits_page.dart';
import 'package:habit_go/app/habits/presentation/state/habits_bloc.dart';
import 'package:habit_go/app/habits/presentation/state/habits_event.dart';
import 'package:habit_go/app/progress/data/models/progress_model.dart';
import 'package:habit_go/app/progress/progress_module.dart';
import 'package:habit_go/core/services/dependency/dependency_service.dart';
import 'package:habit_go/core/services/events/event_service.dart';
import 'package:habit_go/core/themes/light_theme.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [HabitModelSchema, ProgressModelSchema],
    directory: dir.path,
  );

  Dependency.register<Isar>(isar);
  Dependency.register<EventService>(EventService());

  HabitsModule.init();
  ProgressModule.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: LightTheme().theme,
      home: const TestWidget(),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HabitsBloc>(
          create: (BuildContext context) =>
              Dependency.get<HabitsBloc>()..add(HabitLoadEvent()),
        ),
      ],
      child: const HabitsPage(),
    );
  }
}
