import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/habits/presentation/state/habits_form_cubit.dart';
import 'package:habit_go/app/habits/presentation/state/habits_form_state.dart';
import 'package:habit_go/core/widgets/buttons/link_button.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';
import 'package:habit_go/core/widgets/inputs/time_input.dart';

class HabitRemindersList extends StatelessWidget {
  const HabitRemindersList({super.key});

  String _getTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitFormCubit, HabitFormState>(
      builder: (context, state) {
        if (state.status == HabitFormStatus.loading) {
          return const Align(
            alignment: Alignment.centerLeft,
            child: CircularProgressIndicator(),
          );
        }

        return state.reminders.isEmpty
            ? const SizedBox.shrink()
            : Column(
                children: [
                  ...List.generate(
                    state.reminders.length + 1,
                    (index) {
                      return index == state.reminders.length
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: LinkButton(
                                text: 'Add reminder',
                                icon: Icons.add,
                                onTap: () {
                                  context.read<HabitFormCubit>().addReminder(
                                        DateTime.now(),
                                      );
                                },
                              ),
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: TimeInput(
                                    id: 'reminders/reminder-$index',
                                    initialValue:
                                        _getTime(state.reminders[index]),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    FeatherIcons.fi_delete,
                                  ),
                                  onPressed: () => context
                                      .read<HabitFormCubit>()
                                      .removeReminder(
                                        state.reminders[index],
                                      ),
                                ),
                              ],
                            );
                    },
                  ),
                ],
              );
      },
    );
  }
}
