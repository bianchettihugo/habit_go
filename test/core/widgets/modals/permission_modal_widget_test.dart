import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/modals/permission_modal_widget.dart';

void main() {
  testWidgets('core/widgets/modals - tap on allow on PermissionModal',
      (WidgetTester tester) async {
    final lockedPermissions = [NotificationPermission.Alert];
    var allowPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PermissionModal(
                        lockedPermissions: lockedPermissions,
                        onAllowPressed: (BuildContext context) {
                          allowPressed = true;
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    expect(find.text('Deny'), findsOneWidget);
    expect(find.text('Allow'), findsOneWidget);

    await tester.tap(find.text('Allow'));
    await tester.pumpAndSettle();

    expect(allowPressed, isTrue);
  });

  testWidgets('core/widgets/modals - tap on dany on PermissionModal',
      (WidgetTester tester) async {
    final lockedPermissions = [NotificationPermission.Alert];
    var allowPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PermissionModal(
                        lockedPermissions: lockedPermissions,
                        onAllowPressed: (BuildContext context) {
                          allowPressed = true;
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    expect(find.text('Deny'), findsOneWidget);
    expect(find.text('Allow'), findsOneWidget);

    await tester.tap(find.text('Deny'));
    await tester.pumpAndSettle();

    expect(allowPressed, isFalse);
  });
}
