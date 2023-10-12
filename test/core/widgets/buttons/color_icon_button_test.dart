import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/buttons/color_icon_button.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets('core/widgets/buttons - should render a color button',
      (tester) async {
    await tester.pumpWidgetWithApp(
      ColorButton(
        color: Colors.purple,
        onTap: () {},
      ),
    );

    expect(find.byType(ColorButton), findsOneWidget);
  });

  testWidgets('core/widgets/buttons - should perform action on tap',
      (tester) async {
    var test = 0;
    await tester.pumpWidgetWithApp(
      ColorButton(
        color: Colors.purple,
        onTap: () {
          test += 1;
        },
      ),
    );

    await tester.tap(find.byType(ColorButton));

    expect(test, 1);
  });
}
