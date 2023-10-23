import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/widgets/calendar/calendar_item_controller.dart';

void main() {
  late CalendarItemController controller;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    controller = CalendarItemController(
      vsync: const TestVSync(),
      duration: Duration.zero,
    );
  });

  test('core/widgets/calendar - growRight should animate to the right',
      () async {
    await controller.growRight();
    expect(controller.alignment, equals(Alignment.centerLeft));
  });

  test('core/widgets/calendar - growLeft should animate to the left', () async {
    await controller.growLeft();
    expect(controller.alignment, equals(Alignment.centerRight));
  });

  test(
      'core/widgets/calendar - decreaseRight should animate to the right and then back',
      () async {
    await controller.decreaseRight();
    expect(controller.alignment, equals(Alignment.centerRight));
  });

  test(
      'core/widgets/calendar - decreaseLeft should animate to the left and then back',
      () async {
    await controller.decreaseLeft();
    expect(controller.alignment, equals(Alignment.centerLeft));
  });

  test(
      'core/widgets/calendar - slideRight should slide to the right and then back',
      () async {
    await controller.slideRight();
    expect(controller.alignment, equals(Alignment.centerRight));
  });

  test(
      'core/widgets/calendar - slideLeft should slide to the left and then back',
      () async {
    await controller.slideLeft();
    expect(controller.alignment, equals(Alignment.centerLeft));
  });

  test('core/widgets/calendar - rightSlideTo should slide to the right',
      () async {
    await controller.rightSlideTo(0.5);
    expect(controller.alignment, equals(Alignment.centerLeft));
  });

  test('core/widgets/calendar - leftSlideTo should slide to the left',
      () async {
    await controller.leftSlideTo(0.5);
    expect(controller.alignment, equals(Alignment.centerRight));
  });

  tearDown(() {
    controller.dispose();
  });
}
