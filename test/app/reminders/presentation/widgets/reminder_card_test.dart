import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_bloc.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_events.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_state.dart';
import 'package:habit_go/app/reminders/presentation/widgets/reminder_card.dart';
import 'package:habit_go/core/themes/light_theme.dart';
import 'package:habit_go/core/themes/theme_colors.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/data.dart';
import '../../../../utils/mocks.dart';
import '../../../../utils/test_utils.dart';

void main() {
  const time = '13:25';
  late ReminderEntity reminder;
  late RemindersBloc remindersBloc;

  setUp(() {
    reminder = ReminderEntity(
      id: 1,
      title: 'title',
      time: DateTime.now().copyWith(hour: 13, minute: 25),
      days: List.generate(7, (index) => index.isEven ? -1 : 0),
    );
    remindersBloc = MockReminderBloc();
  });

  tearDown(() {
    remindersBloc.close();
  });

  testWidgets('reminders/presentation/widgets - renders the reminder card',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReminderCard(
            reminder: reminder,
          ),
        ),
      ),
    );

    expect(find.text(reminder.title), findsOneWidget);
    expect(find.text(' - $time'), findsOneWidget);
    expect(find.byIcon(FeatherIcons.fi_delete), findsOneWidget);
  });

  testWidgets(
      'reminders/presentation/widgets - deletes the reminder when delete button is pressed',
      (WidgetTester tester) async {
    when(() => remindersBloc.state).thenReturn(
      ReminderState(reminders: [reminderEntity]),
    );
    await tester.pumpWidget(
      BlocProvider.value(
        value: remindersBloc,
        child: MaterialApp(
          home: Scaffold(
            body: ReminderCard(
              reminder: reminder,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(FeatherIcons.fi_delete));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    verify(() => remindersBloc.add(ReminderDeleteEvent(reminder))).called(1);
  });

  testWidgets(
      'reminders/presentation/widgets - checks the color of the text in the Wrap widget',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      ReminderCard(
        reminder: reminder,
      ),
    );

    final wrapFinder = find.byType(Wrap);
    expect(wrapFinder, findsOneWidget);

    final wrapWidget = tester.widget<Wrap>(wrapFinder);
    final wrapChildren = wrapWidget.children;

    for (var i = 0; i < wrapChildren.length; i++) {
      final child = (wrapChildren[i] as Padding).child;
      final text = tester.widget<Text>(find.byWidget(child!));
      final color = reminder.days[i] >= 0
          ? LightTheme().theme.colorScheme.onSurface
          : LightTheme().theme.extension<ThemeColors>()?.grey;

      expect(text.style?.color, color);
    }
  });
}
