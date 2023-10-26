import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/presentation/pages/habits_form_page.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/checkboxes/checkbox_indicator.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';

class HabitCard extends StatefulWidget {
  final HabitEntity habit;
  final int index;
  final bool show;
  final Function(Map<String, dynamic>)? onClosed;
  final VoidCallback? onPressed;

  const HabitCard(
    this.habit, {
    this.index = 0,
    this.show = true,
    this.onClosed,
    this.onPressed,
    super.key,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> {
  late HabitEntity _habit;
  late int _repeat;
  late int _totalRepeat;

  @override
  void initState() {
    _habit = widget.habit;
    _repeat = widget.habit.progress[widget.index];
    _totalRepeat = widget.habit.repeat;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !widget.show
        ? const SizedBox()
        : OpenContainer<Map<String, dynamic>>(
            transitionType: ContainerTransitionType.fadeThrough,
            closedElevation: 0,
            onClosed: (data) {
              if (data != null) {
                widget.onClosed?.call(data);
              }
            },
            closedBuilder: (context, openMenu) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: ListTile(
                  leading: SizedBox(
                    height: double.maxFinite,
                    width: 45,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.theme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          FeatherIcons.icons[widget.habit.icon],
                          color: context.theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  tileColor: context.theme.canvasColor,
                  title: Text(
                    widget.habit.title,
                    style: context.text.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 130,
                      maxWidth: 140,
                    ),
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      tween: Tween<double>(
                        begin: 0,
                        end: _repeat / _totalRepeat,
                      ),
                      builder: (context, value, _) => LinearProgressIndicator(
                        value: value,
                        minHeight: 5,
                      ),
                    ),
                  ),
                  trailing: SizedBox(
                    width: 42,
                    child: _repeat >= _totalRepeat
                        ? const CheckboxIndicator()
                        : Text(
                            '$_repeat/$_totalRepeat',
                            style: context.text.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  onLongPress: () {
                    openMenu();
                  },
                  onTap: () {
                    if (_repeat >= _habit.repeat) return;
                    setState(() {
                      _repeat++;
                    });
                    widget.onPressed?.call();
                  },
                ),
              );
            },
            openBuilder: (context, closeMenu) {
              return HabitFormPage(
                habit: widget.habit,
                dayIndex: widget.index,
              );
            },
          );
  }
}
