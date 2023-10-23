import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_go/core/widgets/calendar/calendar_item.dart';
import 'package:habit_go/core/widgets/calendar/calendar_item_controller.dart';

class CalendarWidget extends StatefulWidget {
  final ScrollController? scrollController;
  final Function(int)? onItemTap;
  final DateTime? date;

  const CalendarWidget({
    this.onItemTap,
    this.scrollController,
    this.date,
    super.key,
  });

  @override
  State<CalendarWidget> createState() => CalendarWidgetState();
}

class CalendarWidgetState extends State<CalendarWidget> {
  late ScrollController scrollController;
  bool endScroll = false;
  int? selectedIndex;
  late DateTime targetDate;
  late int today;

  final controllers = <CalendarItemController>[];

  int selected = 0;

  @override
  void initState() {
    scrollController = widget.scrollController ?? ScrollController();
    final date = widget.date ?? DateTime.now();
    today = date.day;
    targetDate = DateTime(
      date.year,
      date.month,
      date.day - (date.weekday - 1),
    );
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (endScroll) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  void animateCalendar({required bool right}) {
    if (selectedIndex == null) return;

    if (!right) {
      if (selectedIndex == 6) return;
      controllers[selectedIndex!].decreaseRight();
      controllers[selectedIndex! + 1].growRight();
      selectedIndex = selectedIndex! + 1;
    } else {
      if (selectedIndex == 0) return;
      controllers[selectedIndex!].decreaseLeft();
      controllers[selectedIndex! - 1].growLeft();
      selectedIndex = selectedIndex! - 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        controller: scrollController,
        physics: const PageScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            var now = targetDate;
            if (index > 0) {
              now = now.add(Duration(days: index));
              if (!endScroll && now.day == today && index > 4) {
                endScroll = true;
              }
            }

            if (now.day == today) {
              selectedIndex = index;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: CalendarItem(
                date: now,
                onTap: () async {
                  final sIndex = selectedIndex!;
                  if (sIndex < index) {
                    unawaited(controllers[sIndex].decreaseRight());
                    unawaited(controllers[index].growRight());
                  } else if (sIndex > index) {
                    unawaited(controllers[sIndex].decreaseLeft());
                    unawaited(controllers[index].growLeft());
                  }
                  selectedIndex = index;
                  if (widget.onItemTap != null) {
                    widget.onItemTap?.call(index);
                  }
                },
                register: (controller) {
                  controllers.add(controller);
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}
