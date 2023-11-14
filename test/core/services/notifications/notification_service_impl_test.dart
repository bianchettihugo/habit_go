// ignore_for_file: lines_longer_than_80_chars, unused_local_variable

import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/services/notifications/notification_service.dart';
import 'package:habit_go/core/services/notifications/notification_service_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';
import '../../../utils/test_utils.dart';

void main() {
  late NotificationService notificationService;
  late AwesomeNotifications awesomeNotifications;

  setUp(() {
    awesomeNotifications = MockAwesomeNotifications();
    notificationService = NotificationServiceImpl(
      awesomeNotifications: awesomeNotifications,
    );
  });

  testWidgets(
      'core/services - requestPermissions returns true when all permissions are allowed',
      (tester) async {
    when(
      () => awesomeNotifications.checkPermissionList(
        channelKey: any(named: 'channelKey'),
        permissions: any(named: 'permissions'),
      ),
    ).thenAnswer(
      (_) async => [
        NotificationPermission.Sound,
        NotificationPermission.Vibration,
      ],
    );

    late BuildContext context;
    await tester.pumpWidget(
      Builder(
        builder: (ctx) {
          context = ctx;
          return const SizedBox();
        },
      ),
    );

    final result = await notificationService.requestPermissions(
      context: context,
    );

    expect(result, isTrue);
  });

  testWidgets(
      'core/services - requestPermissions returns false when not all permissions are allowed',
      (tester) async {
    when(
      () => awesomeNotifications.checkPermissionList(
        channelKey: any(named: 'channelKey'),
        permissions: any(named: 'permissions'),
      ),
    ).thenAnswer(
      (_) async => [
        NotificationPermission.Sound,
      ],
    );

    when(
      () => awesomeNotifications.shouldShowRationaleToRequest(
        channelKey: any(named: 'channelKey'),
        permissions: any(named: 'permissions'),
      ),
    ).thenAnswer(
      (_) async => [
        NotificationPermission.Vibration,
      ],
    );

    when(
      () => awesomeNotifications.requestPermissionToSendNotifications(
        channelKey: any(named: 'channelKey'),
        permissions: any(named: 'permissions'),
      ),
    ).thenAnswer((_) async => true);

    late BuildContext context;
    await tester.pumpWidgetWithApp(
      Builder(
        builder: (ctx) {
          context = ctx;
          return const SizedBox();
        },
      ),
    );

    var result = true;
    unawaited(
      notificationService
          .requestPermissions(
            context: context,
          )
          .then((value) => result = value),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('Deny'));

    expect(result, isFalse);
  });

  testWidgets(
      'core/services - requestPermissions shows permission modal when some permissions are locked',
      (tester) async {
    when(
      () => awesomeNotifications.checkPermissionList(
        channelKey: any(named: 'channelKey'),
        permissions: any(named: 'permissions'),
      ),
    ).thenAnswer(
      (_) async => [
        NotificationPermission.Sound,
      ],
    );

    when(
      () => awesomeNotifications.shouldShowRationaleToRequest(
        channelKey: any(named: 'channelKey'),
        permissions: any(named: 'permissions'),
      ),
    ).thenAnswer(
      (_) async => [
        NotificationPermission.Vibration,
      ],
    );

    when(
      () => awesomeNotifications.requestPermissionToSendNotifications(
        channelKey: any(named: 'channelKey'),
        permissions: any(named: 'permissions'),
      ),
    ).thenAnswer((_) async => true);

    late BuildContext context;
    await tester.pumpWidgetWithApp(
      Builder(
        builder: (ctx) {
          context = ctx;
          return const SizedBox();
        },
      ),
    );

    var result = true;
    unawaited(
      notificationService
          .requestPermissions(
            context: context,
          )
          .then((value) => result = value),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text('Allow'));

    expect(find.text('Allow'), findsOneWidget);
  });

  testWidgets(
      'core/services - requestPermissions should not show permission modal when there is no locked permissions',
      (tester) async {
    when(
      () => awesomeNotifications.checkPermissionList(
        channelKey: any(named: 'channelKey'),
        permissions: any(named: 'permissions'),
      ),
    ).thenAnswer(
      (_) async => [
        NotificationPermission.Sound,
      ],
    );

    when(
      () => awesomeNotifications.shouldShowRationaleToRequest(
        channelKey: any(named: 'channelKey'),
        permissions: any(named: 'permissions'),
      ),
    ).thenAnswer(
      (_) async => [],
    );

    when(
      () => awesomeNotifications.requestPermissionToSendNotifications(
        channelKey: any(named: 'channelKey'),
        permissions: any(named: 'permissions'),
      ),
    ).thenAnswer((_) async => true);

    late BuildContext context;
    await tester.pumpWidgetWithApp(
      Builder(
        builder: (ctx) {
          context = ctx;
          return const SizedBox();
        },
      ),
    );

    var result = true;
    unawaited(
      notificationService
          .requestPermissions(
            context: context,
          )
          .then((value) => result = value),
    );

    expect(find.text('Allow'), findsNothing);
  });
}
