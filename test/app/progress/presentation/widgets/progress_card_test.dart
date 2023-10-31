import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/presentation/widgets/progress_card.dart';

void main() {
  testWidgets('progress/presentation/state - renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProgressCard(
            value: 50,
            total: 100,
            icon: Icons.check_circle_outline,
            title: 'Title',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Title'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('renders with default values', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProgressCard(
            value: 0,
            total: 0,
            icon: Icons.check_circle_outline,
          ),
        ),
      ),
    );

    expect(find.text(''), findsWidgets);
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
}
