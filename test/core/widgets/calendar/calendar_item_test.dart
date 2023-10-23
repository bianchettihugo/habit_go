import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/themes/light_theme.dart';
import 'package:habit_go/core/widgets/calendar/calendar_item.dart';
import 'package:intl/intl.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets('core/widgets/calendar - renders date correctly', (tester) async {
    final date = DateTime(2022, 12, 31);
    await tester.pumpWidgetWithApp(
      CalendarItem(date: date),
    );

    expect(
      find.text(DateFormat('EEEE').format(date).substring(0, 3)),
      findsOneWidget,
    );
    expect(find.text('31'), findsOneWidget);
    expect(
      tester.widget(find.byType(AnimatedDefaultTextStyle).first),
      isA<AnimatedDefaultTextStyle>().having(
        (t) => t.style.color,
        'color',
        LightTheme().theme.colorScheme.onBackground,
      ),
    );
  });

  testWidgets('core/widgets/calendar - renders today date correctly',
      (tester) async {
    final date = DateTime.now();
    await tester.pumpWidgetWithApp(
      CalendarItem(date: date),
    );

    await tester.pumpAndSettle();

    expect(
      find.text(DateFormat('EEEE').format(date).substring(0, 3)),
      findsOneWidget,
    );
    expect(find.text(date.day.toString().padLeft(2, '0')), findsOneWidget);
  });

  testWidgets('core/widgets/calendar - calls onTap when tapped',
      (tester) async {
    var tapped = false;
    final date = DateTime(2022, 12, 31);
    await tester.pumpWidgetWithApp(
      CalendarItem(
        date: date,
        onTap: () {
          tapped = true;
        },
      ),
    );
    await tester.tap(find.byType(CalendarItem));
    expect(tapped, isTrue);
  });
}
