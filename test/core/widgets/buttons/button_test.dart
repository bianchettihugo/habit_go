import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/buttons/button.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets('core/widgets/buttons - should render a normal button',
      (tester) async {
    await tester.pumpWidgetWithApp(Button(text: 'Click', onTap: () {}));

    expect(find.byType(Button), findsOneWidget);
    expect(find.text('Click'), findsOneWidget);
  });

  testWidgets('core/widgets/buttons - should render a button with an icon',
      (tester) async {
    await tester.pumpWidgetWithApp(
      Button(text: 'Click', icon: Icons.ac_unit_outlined, onTap: () {}),
    );

    expect(find.byType(Button), findsOneWidget);
    expect(find.text('Click'), findsOneWidget);
    expect(
      tester.widget(find.byType(Icon)),
      isA<Icon>().having((t) => t.icon, 'icon', Icons.ac_unit_outlined),
    );
  });

  testWidgets('core/widgets/buttons - should perform action on tap',
      (tester) async {
    var test = 0;
    await tester.pumpWidgetWithApp(
      Button(
        text: 'Click',
        icon: Icons.ac_unit_outlined,
        onTap: () {
          test += 1;
        },
      ),
    );

    await tester.tap(find.text('Click'));

    expect(test, 1);
  });
}
