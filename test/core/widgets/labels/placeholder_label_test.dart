import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/themes/light_theme.dart';
import 'package:habit_go/core/widgets/labels/placeholder_label.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets('core/widgets/labels - placeholder label tets', (tester) async {
    await tester.pumpWidgetWithApp(
      const PlaceholderLabel(
        label: 'Test',
      ),
    );

    expect(find.byType(PlaceholderLabel), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('core/widgets/labels - placeholder label error tets',
      (tester) async {
    await tester.pumpWidgetWithApp(
      const PlaceholderLabel(
        label: 'Test',
        error: true,
      ),
    );

    expect(find.byType(PlaceholderLabel), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
    expect(
      tester.widget(find.byType(Text)),
      isA<Text>().having(
        (t) => t.style!.color,
        'color',
        LightTheme().theme.colorScheme.error,
      ),
    );
  });

  testWidgets('core/widgets/labels - placeholder label focused tets',
      (tester) async {
    await tester.pumpWidgetWithApp(
      const PlaceholderLabel(
        label: 'Test',
        focused: true,
      ),
    );

    expect(find.byType(PlaceholderLabel), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
    expect(
      tester.widget(find.byType(Text)),
      isA<Text>().having(
        (t) => t.style!.color,
        'color',
        LightTheme().theme.primaryColor,
      ),
    );
  });
}
