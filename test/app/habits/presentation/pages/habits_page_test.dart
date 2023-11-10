import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habit_reminders_usecase.dart';
import 'package:habit_go/app/habits/presentation/pages/habits_page.dart';
import 'package:habit_go/app/habits/presentation/state/habits_bloc.dart';
import 'package:habit_go/app/habits/presentation/state/habits_event.dart';
import 'package:habit_go/app/habits/presentation/state/habits_state.dart';
import 'package:habit_go/app/habits/presentation/widgets/habit_card.dart';
import 'package:habit_go/core/services/dependency/dependency_service.dart';
import 'package:habit_go/core/utils/result.dart';
import 'package:habit_go/core/widgets/calendar/calendar_widget.dart';
import 'package:habit_go/core/widgets/errors/error_widget.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';
import 'package:habit_go/core/widgets/inputs/number_input.dart';
import 'package:habit_go/core/widgets/inputs/text_input.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';

void main() {
  final usecase = MockFetchHabitReminderUsecase();
  late HabitsBloc habitsBloc;

  setUp(() {
    Dependency.register<FetchHabitReminderUsecase>(
      usecase,
    );
    habitsBloc = MockHabitsBloc();
  });

  tearDown(() {
    GetIt.I.unregister<FetchHabitReminderUsecase>();
  });

  testWidgets('habits/presentation/pages - renders CalendarWidget',
      (tester) async {
    final habit = habitEntity2;

    when(() => habitsBloc.state).thenReturn(
      HabitState(
        habits: [habit],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: habitsBloc,
          child: const HabitsPage(),
        ),
      ),
    );

    expect(find.byType(CalendarWidget), findsOneWidget);
  });

  testWidgets('habits/presentation/pages - test calendar widget interactions',
      (tester) async {
    final habit = habitEntity2;

    when(() => habitsBloc.state).thenReturn(
      HabitState(
        habits: [habit],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: habitsBloc,
          child: const HabitsPage(),
        ),
      ),
    );

    await tester.binding.setSurfaceSize(const Size(800, 1600));

    await tester.tap(find.text('Thu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Wed'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fri'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Thu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mon'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Thu'));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(PageView), const Offset(-900, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sun'));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(PageView), const Offset(900, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(PageView), const Offset(900, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(PageView), const Offset(900, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(PageView), const Offset(900, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(PageView), const Offset(900, 0));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(PageView), const Offset(-900, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(PageView), const Offset(-900, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(PageView), const Offset(-900, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(PageView), const Offset(-900, 0));
    await tester.pumpAndSettle();
    await tester.drag(find.byType(PageView), const Offset(-900, 0));
    await tester.pumpAndSettle();

    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('habits/presentation/pages - renders FloatingActionButton',
      (tester) async {
    final habit = habitEntity2;

    when(() => habitsBloc.state).thenReturn(
      HabitState(
        habits: [habit],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: habitsBloc,
          child: const HabitsPage(),
        ),
      ),
    );

    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('habits/presentation/pages - renders HabitCard', (tester) async {
    final habit = habitEntity2;

    when(() => habitsBloc.state).thenReturn(
      HabitState(
        habits: [habit],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: habitsBloc,
          child: const HabitsPage(),
        ),
      ),
    );

    expect(find.byType(HabitCard), findsOneWidget);
    expect(find.text('title'), findsOneWidget);
  });

  testWidgets('habits/presentation/pages - renders HabitErrorWidget',
      (tester) async {
    when(() => habitsBloc.state).thenReturn(
      HabitState(
        habits: [],
        status: HabitStatus.error,
        updateIndex: -1,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: habitsBloc,
          child: const HabitsPage(),
        ),
      ),
    );

    expect(find.byType(CustomErrorWidget), findsOneWidget);

    await tester.tap(find.text('Try again'));
    verify(
      () => habitsBloc.add(
        HabitLoadEvent(),
      ),
    ).called(1);
  });

  testWidgets('habits/presentation/pages - calls HabitsBloc on HabitPressed',
      (tester) async {
    final habit = habitEntity2;

    when(() => habitsBloc.state).thenReturn(
      HabitState(
        habits: [habit],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: habitsBloc,
          child: const HabitsPage(),
        ),
      ),
    );

    await tester.tap(find.byType(HabitCard));
    await tester.pumpAndSettle();

    verify(
      () => habitsBloc.add(
        HabitProgressEvent(
          habit: habit,
          index: DateTime.now().weekday - 1,
        ),
      ),
    ).called(1);
    expect(find.text('2/4'), findsOneWidget);

    if (DateTime.now().weekday == 7) {
      await tester.drag(find.byType(PageView), const Offset(900, 0));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(PageView), const Offset(900, 0));
      await tester.pumpAndSettle();
    }

    await tester.drag(find.byType(PageView), const Offset(-900, 0));
    await tester.pumpAndSettle();

    expect(find.text('2/4'), findsNothing);
    expect(find.text('1/4'), findsOneWidget);

    await tester.tap(find.byType(HabitCard));
    await tester.pumpAndSettle();

    expect(find.text('2/4'), findsOneWidget);
    expect(find.text('1/4'), findsNothing);

    verify(
      () => habitsBloc.add(
        HabitProgressEvent(
          habit: habit,
          index: DateTime.now().weekday,
        ),
      ),
    ).called(1);
  });

  testWidgets('habits/presentation/pages - calls HabitsBloc on HabitReset',
      (tester) async {
    when(() => usecase.call(habitId: 0)).thenAnswer(
      (invocation) async => Result.success([]),
    );
    final habit = habitEntity2;

    when(() => habitsBloc.state).thenReturn(
      HabitState(
        habits: [habit],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: habitsBloc,
          child: const HabitsPage(),
        ),
      ),
    );

    await tester.longPress(find.byType(HabitCard));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(FeatherIcons.fi_refresh_cw));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    verify(
      () => habitsBloc.add(
        HabitResetEvent(
          habit: habit,
          index: DateTime.now().weekday - 1,
        ),
      ),
    ).called(1);
  });

  testWidgets('habits/presentation/pages - calls HabitsBloc on HabitDelete',
      (tester) async {
    when(() => usecase.call(habitId: 0)).thenAnswer(
      (invocation) async => Result.success([]),
    );
    final habit = habitEntity2;

    when(() => habitsBloc.state).thenReturn(
      HabitState(
        habits: [habit],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: habitsBloc,
          child: const HabitsPage(),
        ),
      ),
    );

    await tester.longPress(find.byType(HabitCard));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(FeatherIcons.fi_delete));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();

    verify(
      () => habitsBloc.add(
        HabitDeleteEvent(habit),
      ),
    ).called(1);
  });

  testWidgets('habits/presentation/pages - calls HabitsBloc on HabitAdd',
      (tester) async {
    when(() => usecase.call(habitId: 0)).thenAnswer(
      (invocation) async => Result.success([]),
    );
    when(() => habitsBloc.state).thenReturn(
      HabitState(
        habits: [],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: habitsBloc,
          child: const HabitsPage(),
        ),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextInput), 'title');
    await tester.enterText(find.byType(NumberInput), '5');
    await tester.tap(find.byType(Checkbox).last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create habit'));
    await tester.pumpAndSettle();

    verify(
      () => habitsBloc.add(
        HabitAddEvent(habitDataCreate2),
      ),
    ).called(1);
  });

  testWidgets('habits/presentation/pages - calls HabitsBloc on HabitUpdate',
      (tester) async {
    when(() => usecase.call(habitId: 0)).thenAnswer(
      (invocation) async => Result.success([]),
    );
    final habit = habitEntity2;

    when(() => habitsBloc.state).thenReturn(
      HabitState(
        habits: [habit],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: habitsBloc,
          child: const HabitsPage(),
        ),
      ),
    );

    await tester.longPress(find.byType(HabitCard));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(NumberInput), '5');
    await tester.pump();
    await tester.tap(find.text('Update habit'));
    await tester.pumpAndSettle();

    verify(
      () => habitsBloc.add(
        HabitUpdateEvent(habitDataUpdate2),
      ),
    ).called(1);
  });

  testWidgets('habits/presentation/pages - bloc methods tests', (tester) async {
    final key = GlobalKey<HabitsPageState>();
    final habit = habitEntity2;
    BuildContext? ctx;

    when(() => habitsBloc.state).thenReturn(
      HabitState(
        habits: [habit],
        status: HabitStatus.loaded,
        updateIndex: -1,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: habitsBloc,
          child: Builder(
            builder: (context) {
              ctx = context;
              return HabitsPage(key: key);
            },
          ),
        ),
      ),
    );

    key.currentState!.onHabitEvent(ctx!, habitsBloc.state);
    key.currentState!.buildEntireHabitsList(habitsBloc.state, habitsBloc.state);
    key.currentState!.buildHabit(0, habitsBloc.state, habitsBloc.state);

    habitsBloc.emit(HabitState(status: HabitStatus.loading));
    await tester.pumpAndSettle();
  });

  tearDown(() {
    habitsBloc.close();
  });
}
