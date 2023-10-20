import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/inputs/text_input.dart';
import 'package:habit_go/core/widgets/labels/placeholder_label.dart';

import '../../../utils/test_utils.dart';

void main() {
  late final FocusNode focus;

  setUpAll(() {
    focus = FocusNode();
  });

  testWidgets('core/widgets/inputs - text input test', (tester) async {
    await tester.pumpWidgetWithApp(
      const TextInput(),
    );

    expect(find.byType(TextInput), findsOneWidget);
    expect(find.byType(PlaceholderLabel), findsNothing);
  });

  testWidgets('core/widgets/inputs - text input test with label',
      (tester) async {
    await tester.pumpWidgetWithApp(
      const TextInput(
        initialValue: 'LL',
        label: 'Test input',
      ),
    );

    expect(find.byType(TextInput), findsOneWidget);
    expect(find.byType(PlaceholderLabel), findsOneWidget);
    expect(find.text('Test input'), findsOneWidget);
  });

  testWidgets('core/widgets/inputs - text input functional test',
      (tester) async {
    await tester.pumpWidgetWithApp(
      TextInput(
        focus: focus,
        label: 'Test input',
      ),
    );

    focus.requestFocus();
    await tester.enterText(find.byType(TextField), 'TEST');
    await tester.pump();

    expect(find.text('TEST'), findsOneWidget);
  });

  testWidgets('core/widgets/inputs - text input error test', (tester) async {
    await tester.pumpWidgetWithApp(
      const TextInput(
        label: 'Test input',
        error: true,
      ),
    );

    focus.requestFocus();
    await tester.enterText(find.byType(TextField), 'TEST');
    await tester.pump();

    expect(find.text('TEST'), findsOneWidget);
  });
}
