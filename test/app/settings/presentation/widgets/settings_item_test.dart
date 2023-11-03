import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/settings/presentation/widgets/settings_item.dart';

void main() {
  testWidgets('settings/presentation/state - renders correctly',
      (WidgetTester tester) async {
    const title = 'Settings Item';
    const icon = Icons.settings;
    var pressed = false;
    bool onPressed() => pressed = true;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SettingsItem(
            title: title,
            icon: icon,
            onPressed: onPressed,
          ),
        ),
      ),
    );

    expect(find.text(title), findsOneWidget);
    expect(find.byIcon(icon), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);

    await tester.tap(find.byType(ListTile));
    expect(pressed, true);
  });
}
