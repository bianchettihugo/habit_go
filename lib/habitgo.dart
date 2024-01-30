// coverage:ignore-file

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/habits/presentation/pages/habits_page.dart';
import 'package:habit_go/app/habits/presentation/state/habits_bloc.dart';
import 'package:habit_go/app/habits/presentation/state/habits_event.dart';
import 'package:habit_go/app/progress/presentation/pages/progress_page.dart';
import 'package:habit_go/app/progress/presentation/state/progress_bloc.dart';
import 'package:habit_go/app/progress/presentation/state/progress_event.dart';
import 'package:habit_go/app/reminders/presentation/pages/reminders_page.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';
import 'package:habit_go/app/settings/presentation/pages/settings_page.dart';
import 'package:habit_go/app/settings/presentation/state/settings_cubit.dart';
import 'package:habit_go/core/services/dependency/dependency_service.dart';
import 'package:habit_go/core/themes/light_theme.dart';
import 'package:habit_go/core/utils/extensions.dart';

class HabitGo extends StatefulWidget {
  const HabitGo({super.key});

  @override
  State<HabitGo> createState() => _HabitGoState();
}

class _HabitGoState extends State<HabitGo> with WidgetsBindingObserver {
  int selectedIndex = 0;
  final _screens = [
    () => const HabitsPage(),
    () => const ProgressPage(),
    () => const RemindersPage(),
    () => const SettingsPage(),
  ];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Dependency.get<HabitsBloc>().add(HabitClearEvent());
      Dependency.get<ProgressBloc>().add(const ProgressResetEvent());
    }
  }

  ThemeData _getTheme(BuildContext context, SettingsEntity settings) {
    switch (settings.themeMode) {
      case AppTheme.light:
        return LightTheme().theme;
      case AppTheme.dark:
        return LightTheme().theme;
      case AppTheme.system:
        final brightness = MediaQuery.of(context).platformBrightness;
        final isDarkMode = brightness == Brightness.dark;
        return isDarkMode ? LightTheme().theme : LightTheme().theme;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsEntity>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, settings) {
        return MaterialApp(
          title: 'HabitGo',
          debugShowCheckedModeBanner: false,
          theme: _getTheme(context, settings),
          home: Scaffold(
            body: _screens[selectedIndex](),
            bottomNavigationBar: NavigationBar(
              backgroundColor: context.theme.canvasColor,
              indicatorColor: context.theme.canvasColor,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              destinations: <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.calendar_month,
                    color: context.theme.primaryColor,
                  ),
                  icon: Icon(
                    Icons.calendar_month,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  label: 'Habits',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.leaderboard,
                    color: context.theme.primaryColor,
                  ),
                  icon: Icon(
                    Icons.leaderboard,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  label: 'Progress',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.notifications,
                    color: context.theme.primaryColor,
                  ),
                  icon: Icon(
                    Icons.notifications,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  label: 'Reminders',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.settings,
                    color: context.theme.primaryColor,
                  ),
                  icon: Icon(
                    Icons.settings,
                    color: context.theme.colorScheme.onSurface,
                  ),
                  label: 'Settings',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
