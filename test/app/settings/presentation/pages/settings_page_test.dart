import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/settings/domain/entities/settings_entity.dart';
import 'package:habit_go/app/settings/presentation/pages/settings_page.dart';
import 'package:habit_go/app/settings/presentation/state/settings_cubit.dart';
import 'package:habit_go/app/settings/presentation/widgets/settings_item.dart';
import 'package:habit_go/core/widgets/radios/radio_option.dart';
import 'package:habit_go/core/widgets/switches/switch_option.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  late SettingsCubit settingsCubit;

  setUp(() {
    settingsCubit = MockSettingsCubit();
  });

  tearDown(() {
    settingsCubit.close();
  });

  testWidgets('settings/presentation/pages - renders the app bar',
      (WidgetTester tester) async {
    when(() => settingsCubit.state).thenReturn(settingsEntity);
    const page = SettingsPage();
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: settingsCubit,
          child: page,
        ),
      ),
    );

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(page.themeChanged(settingsEntity, settingsEntity), false);
  });

  testWidgets('settings/presentation/pages - renders the app theme section',
      (WidgetTester tester) async {
    when(() => settingsCubit.state).thenReturn(settingsEntity);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: settingsCubit,
          child: const SettingsPage(),
        ),
      ),
    );

    expect(find.text('App theme'), findsOneWidget);
    expect(find.byType(RadioOption<AppTheme>), findsOneWidget);
  });

  testWidgets(
      'settings/presentation/pages - renders the enable animations switch',
      (WidgetTester tester) async {
    when(() => settingsCubit.state).thenReturn(settingsEntity);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: settingsCubit,
          child: const SettingsPage(),
        ),
      ),
    );

    expect(find.text('Enable animations'), findsOneWidget);
    expect(find.byType(SwitchOption), findsNWidgets(2));
  });

  testWidgets(
      'settings/presentation/pages - renders the enable notifications switch',
      (WidgetTester tester) async {
    when(() => settingsCubit.state).thenReturn(settingsEntity);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: settingsCubit,
          child: const SettingsPage(),
        ),
      ),
    );

    expect(find.text('Enable notifications'), findsOneWidget);
    expect(find.byType(SwitchOption), findsNWidgets(2));
  });

  testWidgets('settings/presentation/pages - renders the about section',
      (WidgetTester tester) async {
    when(() => settingsCubit.state).thenReturn(settingsEntity);
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: settingsCubit,
          child: const SettingsPage(),
        ),
      ),
    );

    expect(find.text('About HabitGo'), findsOneWidget);
    expect(find.byType(SettingsItem), findsOneWidget);

    await tester.tap(find.byType(SettingsItem));
  });

  testWidgets(
      'settings/presentation/pages - updates app theme when radio option is changed',
      (WidgetTester tester) async {
    when(() => settingsCubit.state).thenReturn(settingsEntity);
    when(() => settingsCubit.updateTheme(AppTheme.dark))
        .thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: settingsCubit,
          child: const SettingsPage(),
        ),
      ),
    );

    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    verify(() => settingsCubit.updateTheme(AppTheme.dark)).called(1);
  });

  testWidgets(
      'settings/presentation/pages - updates app animations when switch option is changed',
      (WidgetTester tester) async {
    when(() => settingsCubit.state).thenReturn(settingsEntity);
    when(() => settingsCubit.updateAppAnimations(false))
        .thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: settingsCubit,
          child: const SettingsPage(),
        ),
      ),
    );

    await tester.tap(find.byType(SwitchOption).first);
    await tester.pumpAndSettle();

    verify(() => settingsCubit.updateAppAnimations(false)).called(1);
  });

  testWidgets(
      'settings/presentation/pages - updates notifications when switch option is changed',
      (WidgetTester tester) async {
    when(() => settingsCubit.state).thenReturn(settingsEntity);
    when(() => settingsCubit.updateNotifications(false))
        .thenAnswer((_) async {});

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: settingsCubit,
          child: const SettingsPage(),
        ),
      ),
    );

    await tester.tap(find.byType(SwitchOption).last);
    await tester.pumpAndSettle();

    verify(() => settingsCubit.updateNotifications(false)).called(1);
  });
}
