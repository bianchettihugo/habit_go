import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/calendar/calendar_item_controller.dart';
import 'package:intl/intl.dart' as intl;

class CalendarItem extends StatefulWidget {
  final DateTime date;
  final VoidCallback? onTap;
  final CalendarItemController? controller;
  final Function(CalendarItemController)? register;

  const CalendarItem({
    required this.date,
    this.controller,
    this.onTap,
    this.register,
    super.key,
  });

  @override
  State<CalendarItem> createState() => _CalendarItemState();
}

class _CalendarItemState extends State<CalendarItem>
    with TickerProviderStateMixin {
  late DateTime today;
  late CalendarItemController _controller;
  late Animation _animation;

  bool primary = false;
  bool completed = false;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    _controller = widget.controller ??
        CalendarItemController(
          vsync: this,
          duration: const Duration(milliseconds: 140),
        );
    _animation = Tween<double>(
      begin: 0,
      end: 64,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        completed = status == AnimationStatus.completed;
      }
    });
    _animation.addListener(() {
      if (_animation.value > 0.1 && !primary && !completed) {
        setState(() {
          primary = true;
        });
      } else if (_animation.value < 63 && primary && completed) {
        setState(() {
          primary = false;
        });
      }
    });
    if (today.day == widget.date.day) {
      _controller.growRight();
    }
    widget.register?.call(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Ink(
              decoration: BoxDecoration(
                color: context.theme.canvasColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned.fill(
                child: Align(
                  alignment: _controller.alignment,
                  child: Container(
                    width: _animation.value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              );
            },
          ),
          Container(
            width: 64,
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 60),
                  style: context.text.bodyMedium!.copyWith(
                    color: primary
                        ? context.theme.colorScheme.onPrimary
                        : widget.date.day == today.day
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.onBackground,
                  ),
                  child: Text(
                    intl.DateFormat('EEEE').format(widget.date).substring(0, 3),
                  ),
                ),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 60),
                  style: context.text.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: primary
                        ? context.theme.colorScheme.onPrimary
                        : widget.date.day == today.day
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.onBackground,
                  ),
                  child: Text(
                    widget.date.day.toString().padLeft(2, '0'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
