import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/calendar/calendar_item.dart';
import 'package:habit_go/core/widgets/calendar/calendar_widget.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets('core/widgets/calendar - should render 7 CalendarItems',
      (tester) async {
    await tester.pumpWidgetWithApp(
      const CalendarWidget(),
    );

    expect(find.byType(CalendarItem), findsNWidgets(7));
  });

  testWidgets(
      'core/widgets/calendar - should call onItemTap when a CalendarItem is tapped',
      (tester) async {
    var tappedIndex = -1;
    await tester.pumpWidgetWithApp(
      CalendarWidget(
        onItemTap: (index) {
          tappedIndex = index;
        },
      ),
    );

    await tester.tap(find.byType(CalendarItem).first);
    await tester.pumpAndSettle();
    expect(tappedIndex, 0);

    await tester.tap(find.byType(CalendarItem).last);
    await tester.pumpAndSettle();
    expect(tappedIndex, 6);
  });

  testWidgets(
      'core/widgets/calendar - should animate the CalendarItems when a CalendarItem is tapped',
      (tester) async {
    final key = GlobalKey<CalendarWidgetState>();
    await tester.pumpWidgetWithApp(
      CalendarWidget(
        key: key,
        date: DateTime(2023, 10, 28),
      ),
    );

    for (var i = 0; i < 7; i++) {
      await tester.tap(find.byType(CalendarItem).at(i));
      await tester.pumpAndSettle();

      if (i > 0) {
        expect(key.currentState!.controllers[i].value > 0.9, true);
        expect(
          key.currentState!.controllers[i - 1].value < 0.1,
          true,
        );
      }
    }
  });

  testWidgets('core/widgets/calendar - animateCalendar method test',
      (tester) async {
    final key = GlobalKey<CalendarWidgetState>();
    await tester.pumpWidgetWithApp(
      CalendarWidget(
        key: key,
      ),
    );

    await tester.tap(find.byType(CalendarItem).first);
    await tester.pumpAndSettle();

    key.currentState!.animateCalendar(right: false);
    await tester.pumpAndSettle();

    expect(key.currentState!.controllers[1].value > 0.9, true);
    expect(
      key.currentState!.controllers[0].value < 0.1,
      true,
    );

    key.currentState!.animateCalendar(right: true);
    await tester.pumpAndSettle();

    expect(key.currentState!.controllers[0].value > 0.9, true);
    expect(
      key.currentState!.controllers[1].value < 0.1,
      true,
    );
  });
}
