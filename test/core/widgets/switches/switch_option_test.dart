import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/switches/switch_option.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets('core/widgets/switches - renders the switch',
      (WidgetTester tester) async {
    await tester.pumpWidgetWithApp(
      Column(
        children: [
          const SwitchOption(
            id: 'id',
            title: 'title',
          ),
          SwitchOption(
            id: 'id2',
            title: '',
            onChanged: (v) {},
          ),
        ],
      ),
    );

    expect(find.text('title'), findsOneWidget);
    expect(find.byType(SwitchOption), findsWidgets);
    expect(find.byType(Switch), findsWidgets);
  });
}
