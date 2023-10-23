import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/checkboxes/option_checkbox.dart';
import 'package:intl/intl.dart' as intl;

class WeekDayInput extends StatefulWidget {
  final List<int>? days;
  final String? id;

  const WeekDayInput({this.days, this.id, super.key});

  @override
  State<WeekDayInput> createState() => _WeekDayInputState();
}

class _WeekDayInputState extends State<WeekDayInput> {
  late DateTime _initialDate;
  late List<int> _days;
  bool error = false;

  @override
  void initState() {
    final date = DateTime.now();
    _initialDate = DateTime(
      date.year,
      date.month,
      date.day - (date.weekday - 1),
    );
    _days = widget.days ?? List.filled(7, 0);
    super.initState();
  }

  String? _validate(List<int>? value) {
    if (_days.every((element) => element < 0)) {
      setState(() {
        error = true;
      });
      return ' ';
    }

    setState(() {
      error = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.days != null && widget.days!.length < 7) {
      return const SizedBox();
    }

    return DataFormField(
      value: _days,
      validator: _validate,
      id: widget.id ?? '',
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: context.theme.canvasColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: context.themeColors.grey,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select the days of the week',
                  style: context.text.bodyMedium
                      ?.copyWith(color: context.theme.hintColor),
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: List.generate(7, (index) {
                    final now = _initialDate.add(Duration(days: index));
                    return DayButton(
                      label: intl.DateFormat('EEEE')
                          .format(now)
                          .substring(0, 1)
                          .toUpperCase(),
                      enabled: _days[index] >= 0,
                      onPressed: (active) {
                        _days[index] = active ? 0 : -1;
                      },
                    );
                  }),
                ),
              ],
            ),
            if (error)
              Text(
                'You must select at least one day',
                textAlign: TextAlign.start,
                style: context.text.bodyMedium?.copyWith(
                  color: context.theme.colorScheme.error,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DayButton extends StatefulWidget {
  final String label;
  final Function(bool) onPressed;
  final bool? enabled;

  const DayButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled,
  });

  @override
  State<DayButton> createState() => _DayButtonState();
}

class _DayButtonState extends State<DayButton> {
  late bool active;

  @override
  void initState() {
    active = widget.enabled ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.label,
          style: context.text.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        OptionCheckbox(
          active: active,
          onChanged: widget.onPressed,
        ),
      ],
    );
  }
}
