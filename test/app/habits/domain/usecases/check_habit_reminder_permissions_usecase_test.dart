import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/habits/domain/usecases/check_habit_reminder_permissions_usecase.dart';
import 'package:habit_go/core/services/notifications/notification_service.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';
import '../../../../utils/test_utils.dart';

void main() {
  late CheckHabitReminderPermissionsUsecaseImpl usecase;
  late NotificationService mockNotificationService;

  setUp(() {
    mockNotificationService = MockNotificationsService();
    usecase = CheckHabitReminderPermissionsUsecaseImpl(
      notificationService: mockNotificationService,
    );
  });

  testWidgets('requestPermissions returns true when permission is granted',
      (tester) async {
    late BuildContext ctx;

    await tester.pumpWidgetWithApp(
      Builder(
        builder: (context) {
          ctx = context;
          return const SizedBox();
        },
      ),
    );
    registerFallbackValue(ctx);
    when(
      () => mockNotificationService.requestPermissions(
        context: any(named: 'context'),
      ),
    ).thenAnswer((_) async => true);

    final result = await usecase.call(context: ctx);

    expect(result, true);
    verify(() => mockNotificationService.requestPermissions(context: ctx))
        .called(1);
  });

  testWidgets('requestPermissions returns false when permission is not granted',
      (tester) async {
    late BuildContext ctx;

    await tester.pumpWidgetWithApp(
      Builder(
        builder: (context) {
          ctx = context;
          return const SizedBox();
        },
      ),
    );
    registerFallbackValue(ctx);
    when(
      () => mockNotificationService.requestPermissions(
        context: any(named: 'context'),
      ),
    ).thenAnswer((_) async => false);

    final result = await usecase.call(context: ctx);

    expect(result, false);
    verify(() => mockNotificationService.requestPermissions(context: ctx))
        .called(1);
  });
}
