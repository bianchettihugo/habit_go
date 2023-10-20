import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/inputs/number_input.dart';
import 'package:habit_go/core/widgets/labels/placeholder_label.dart';

import '../../../utils/test_utils.dart';

void main() {
  late final FocusNode focus;

  setUpAll(() {
    focus = FocusNode();
  });

  testWidgets('core/widgets/inputs - number input test', (tester) async {
    await tester.pumpWidgetWithApp(
      const NumberInput(),
    );

    expect(find.byType(NumberInput), findsOneWidget);
    expect(find.byType(PlaceholderLabel), findsNothing);
  });

  testWidgets('core/widgets/inputs - number input test with label',
      (tester) async {
    await tester.pumpWidgetWithApp(
      const NumberInput(
        initialValue: '2',
        label: 'Test input',
      ),
    );

    expect(find.byType(NumberInput), findsOneWidget);
    expect(find.byType(PlaceholderLabel), findsOneWidget);
    expect(find.text('Test input'), findsOneWidget);
  });

  testWidgets('core/widgets/inputs - number input funcitonal test',
      (tester) async {
    await tester.pumpWidgetWithApp(
      NumberInput(
        focus: focus,
        label: 'Test input',
      ),
    );

    focus.requestFocus();
    await tester.enterText(find.byType(TextField), '2');
    await tester.pump();

    expect(find.text('2'), findsOneWidget);
    await tester.tap(find.byKey(const Key('number_input_down')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('number_input_down')));
    await tester.pump();

    expect(find.text('2'), findsNothing);
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    await tester.tap(find.byKey(const Key('number_input_up')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('number_input_up')));
    await tester.pump();

    expect(find.text('1'), findsNothing);
    expect(find.text('2'), findsNothing);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('core/widgets/inputs - text input error test', (tester) async {
    await tester.pumpWidgetWithApp(
      const NumberInput(
        label: 'Test input',
        error: true,
      ),
    );

    focus.requestFocus();
    await tester.enterText(find.byType(TextField), '1');
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}
