import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/icons/icons_list.dart';
import 'package:habit_go/core/widgets/inputs/text_input.dart';

import '../../../utils/test_utils.dart';

void main() {
  late Function(String) onLongTap;
  late Function(String) onTap;

  setUp(() {
    onLongTap = (String icon) {};
    onTap = (String icon) {};
  });

  testWidgets('core/widgets/icons - icons list test',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      IconsList(
        onLongTap: onLongTap,
        onTap: onTap,
      ),
    );

    expect(find.text('Select an icon'), findsOneWidget);
    expect(find.byType(TextInput), findsOneWidget);
    expect(find.byType(ListTile), findsWidgets);
  });

  testWidgets('core/widgets/icons - calls onTap when a list tile is tapped',
      (WidgetTester tester) async {
    var tappedIcon = '';
    onTap = (String icon) {
      tappedIcon = icon;
    };

    await tester.pumpWidgetWithApp(
      IconsList(
        onLongTap: onLongTap,
        onTap: onTap,
      ),
    );

    await tester.tap(find.byType(ListTile).first);
    expect(tappedIcon, isNotEmpty);
  });

  testWidgets(
      'core/widgets/icons -  calls onLongTap when a list tile is long pressed',
      (WidgetTester tester) async {
    var longPressedIcon = '';
    onLongTap = (String icon) {
      longPressedIcon = icon;
    };

    await tester.pumpWidgetWithApp(
      IconsList(
        onLongTap: onLongTap,
        onTap: onTap,
      ),
    );

    await tester.longPress(find.byType(ListTile).first);
    expect(longPressedIcon, isNotEmpty);
  });

  testWidgets(
      'core/widgets/icons - filters the list when the user types something on the search text field',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      IconsList(
        onLongTap: onLongTap,
        onTap: onTap,
      ),
    );

    expect(find.byType(ListTile), findsAtLeastNWidgets(5));

    await tester.enterText(find.byType(TextInput), 'zap');
    await tester.pumpAndSettle(const Duration(milliseconds: 600));

    expect(find.byType(ListTile), findsNWidgets(2));

    await tester.enterText(find.byType(TextInput), '');
    await tester.pumpAndSettle(const Duration(milliseconds: 600));

    expect(find.byType(ListTile), findsAtLeastNWidgets(5));
  });

  testWidgets(
      'core/widgets/icons - calls onTap when a list tile translated in pt is tapped',
      (WidgetTester tester) async {
    var tappedIcon = '';
    onTap = (String icon) {
      tappedIcon = icon;
    };

    await tester.pumpWidgetWithApp(
      IconsList(
        onLongTap: onLongTap,
        onTap: onTap,
      ),
      locale: const Locale('pt'),
    );

    await tester.tap(find.byType(ListTile).first);
    expect(tappedIcon, 'activity');
  });
}
