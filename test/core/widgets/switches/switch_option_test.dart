import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/switches/switch_option.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets('core/widgets/switches - renders the switch',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      const SwitchOption(
        id: 'id',
        title: 'title',
      ),
    );

    expect(find.text('title'), findsOneWidget);
    expect(find.byType(SwitchOption), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
  });
}
