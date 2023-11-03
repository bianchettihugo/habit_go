import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/radios/radio_option.dart';

import '../../../utils/test_utils.dart';

void main() {
  testWidgets('core/widgets/radios - renders the radio options',
      (WidgetTester tester) async {
    final options = {
      'Option 1': 'option1',
      'Option 2': 'option2',
      'Option 3': 'option3',
    };
    String? selectedOption;

    RadioOption<String>(
      options: options,
      onChanged: (value) {
        selectedOption = value;
      },
      selectedOption: 'option2',
    );

    await tester.pumpWidgetWithApp(
      RadioOption<String>(
        options: options,
        onChanged: (value) {
          selectedOption = value;
        },
      ),
    );

    expect(find.byType(RadioOption<String>), findsOneWidget);
    expect(find.byType(RadioListTile<String>), findsNWidgets(options.length));

    for (final option in options.entries) {
      final optionTile = find.byWidgetPredicate(
        (widget) =>
            widget is RadioListTile<String> &&
            widget.title is Text &&
            (widget.title! as Text).data == option.key,
      );
      expect(optionTile, findsOneWidget);
    }

    await tester.tap(find.byType(RadioListTile<String>).last);
    await tester.pumpAndSettle();

    expect(selectedOption, 'option3');
  });
}
