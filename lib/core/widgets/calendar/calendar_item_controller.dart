import 'package:flutter/material.dart';

class CalendarItemController extends AnimationController {
  Alignment alignment = Alignment.centerLeft;
  CalendarItemController({required super.vsync, super.duration});

  Future<void> growRight() async {
    alignment = Alignment.centerLeft;
    await forward();
  }

  Future<void> growLeft() async {
    alignment = Alignment.centerRight;
    await forward();
  }

  Future<void> decreaseRight() async {
    alignment = Alignment.centerRight;
    await reverse();
  }

  Future<void> decreaseLeft() async {
    alignment = Alignment.centerLeft;
    await reverse();
  }

  Future<void> slideRight() async {
    alignment = Alignment.centerLeft;
    await forward();
    alignment = Alignment.centerRight;
    await reverse();
  }

  Future<void> slideLeft() async {
    alignment = Alignment.centerRight;
    await forward();
    alignment = Alignment.centerLeft;
    await reverse();
  }

  Future<void> rightSlideTo(double target) async {
    alignment = Alignment.centerLeft;
    await animateTo(target);
  }

  Future<void> leftSlideTo(double target) async {
    alignment = Alignment.centerRight;
    await animateTo(target);
  }
}
