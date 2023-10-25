import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/utils/dialogs.dart';

import '../../utils/test_utils.dart';

void main() {
  testWidgets(
      'core/utils - showAlertDialog displays the correct title and description',
      (WidgetTester tester) async {
    BuildContext? context;

    await tester.pumpWidgetWithApp(
      Builder(
        builder: (c) {
          context = c;
          return ElevatedButton(
            onPressed: () async {
              unawaited(
                Dialogs.showAlertDialog(
                  context: context!,
                  title: 'Test Title',
                  description: 'Test Description',
                ),
              );
            },
            child: const Text('Press'),
          );
        },
      ),
    );

    await tester.tap(find.text('Press'));
    await tester.pumpAndSettle();

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);

    await tester.tap(find.text('OK'));
  });

  testWidgets(
      'core/utils - showConfirmationDialog displays the correct title and description',
      (WidgetTester tester) async {
    BuildContext? context;

    await tester.pumpWidgetWithApp(
      Builder(
        builder: (c) {
          context = c;
          return ElevatedButton(
            onPressed: () async {
              unawaited(
                Dialogs.showConfirmationDialog(
                  context: context!,
                  title: 'Test Title',
                  description: 'Test Description',
                ),
              );
            },
            child: const Text('Press'),
          );
        },
      ),
    );

    await tester.tap(find.text('Press'));
    await tester.pumpAndSettle();

    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
  });

  testWidgets(
      'core/utils - showConfirmationDialog returns true when the continue button is pressed',
      (WidgetTester tester) async {
    BuildContext? context;

    await tester.pumpWidgetWithApp(
      Builder(
        builder: (c) {
          context = c;
          return ElevatedButton(
            onPressed: () async {
              final result = await Dialogs.showConfirmationDialog(
                context: context!,
                title: 'Test Title',
                description: 'Test Description',
                continueText: 'Continue',
              );
              expect(result, true);
            },
            child: const Text('Press'),
          );
        },
      ),
    );

    await tester.tap(find.text('Press'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue'));
  });
}
