import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';
import 'package:habit_go/core/widgets/icons/icons_list.dart';
import 'package:habit_go/core/widgets/inputs/icon_input.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets('core/widgets/inputs - renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const IconInput(),
    );

    expect(find.byType(IconInput), findsOneWidget);
  });

  testWidgets('core/widgets/inputs - displays default icon',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const IconInput(),
    );

    expect(find.byIcon(FeatherIcons.fi_clipboard), findsOneWidget);
  });

  testWidgets('core/widgets/inputs - displays selected icon',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const IconInput(
        iconName: 'activity',
      ),
    );

    expect(find.byIcon(FeatherIcons.fi_activity), findsOneWidget);
  });

  testWidgets('core/widgets/inputs - opens icon list on tap',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const IconInput(),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    expect(find.byType(IconsList), findsOneWidget);
  });

  testWidgets('core/widgets/inputs - selects icon from list',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const IconInput(),
    );

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    await tester.tap(find.text('alert octagon'));
    await tester.pumpAndSettle();

    expect(find.byIcon(FeatherIcons.fi_alert_octagon), findsOneWidget);
  });
}
