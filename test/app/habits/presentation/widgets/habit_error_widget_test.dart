import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/presentation/widgets/habit_error_widget.dart';

void main() {
  testWidgets('habits/presentation/widgets - renders error message',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HabitErrorWidget(
            onTryAgain: () {},
          ),
        ),
      ),
    );

    expect(find.text('Ops, there was a problem'), findsOneWidget);
    expect(
      find.text(
        'It was not possible to complete the operation.\nPlease, try again.',
      ),
      findsOneWidget,
    );
  });

  testWidgets(
      'habits/presentation/widgets - calls onTryAgain when try again button is tapped',
      (WidgetTester tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HabitErrorWidget(
            onTryAgain: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Try again'));
    expect(tapped, isTrue);
  });
}
