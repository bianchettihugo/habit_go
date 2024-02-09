import 'package:dataform/dataform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/usecases/check_habit_reminder_permissions_usecase.dart';
import 'package:habit_go/app/habits/domain/usecases/fetch_habit_reminders_usecase.dart';
import 'package:habit_go/app/habits/presentation/state/habits_form_cubit.dart';
import 'package:habit_go/app/habits/presentation/widgets/habit_form_app_bar.dart';
import 'package:habit_go/app/habits/presentation/widgets/habit_reminders_list.dart';
import 'package:habit_go/core/services/dependency/dependency_service.dart';
import 'package:habit_go/core/utils/validators.dart';
import 'package:habit_go/core/widgets/buttons/button.dart';

import 'package:habit_go/core/widgets/inputs/icon_input.dart';
import 'package:habit_go/core/widgets/inputs/number_input.dart';
import 'package:habit_go/core/widgets/inputs/text_input.dart';
import 'package:habit_go/core/widgets/inputs/weekday_input.dart';
import 'package:habit_go/core/widgets/switches/switch_option.dart';

class HabitFormPage extends StatelessWidget {
  final HabitEntity? habit;
  final int dayIndex;

  const HabitFormPage({
    this.habit,
    this.dayIndex = 0,
    super.key,
  });

  void _onSubmit(BuildContext context) {
    final data = DataFormState.of(context).fetchData();
    if (data != null) {
      data.putIfAbsent('notify', () => true);
      data['type'].putIfAbsent('color', () => 'primary');
      if (habit != null) {
        data.putIfAbsent('id', () => habit!.id);
        data.putIfAbsent('result', () => 'update');
        data.putIfAbsent('oldRepeat', () => habit!.repeat);
        data.putIfAbsent('oldProgress', () => habit!.originalProgress);
        Navigator.pop(context, data);
      } else {
        data.putIfAbsent('result', () => 'create');
        Navigator.pop(context, data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HabitFormCubit(
          fetchHabitReminders: Dependency.get<FetchHabitReminderUsecase>(),
          checkHabitReminderPermissions:
              Dependency.get<CheckHabitReminderPermissionsUsecase>(),
        );

        if (habit != null && habit!.id != null) {
          cubit.fetchHabitReminders(habitId: habit!.id!);
        }

        return cubit;
      },
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: HabitFormAppBar(
              habit: habit,
              index: dayIndex,
            ),
            body: DataForm(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconInput(
                                  id: 'type/icon',
                                  iconName: habit?.icon,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextInput(
                                    id: 'name',
                                    placeholder: 'Name',
                                    autoFocus: habit == null,
                                    initialValue: habit?.title,
                                    validate: (str) => {
                                      Validators.isLength(str, 1):
                                          ' Required field',
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            NumberInput(
                              id: 'repeat',
                              label: 'How many times a day',
                              formatter: (str) => int.tryParse(str ?? ''),
                              initialValue: habit?.repeat.toString(),
                              validate: (str) => {
                                Validators.isLength(str, 1): ' Required field',
                                Validators.isGreaterThan(str ?? '', 0):
                                    ' Must be a a number greater than 0',
                              },
                            ),
                            const SizedBox(height: 20),
                            WeekDayInput(
                              days: habit?.progress,
                              id: 'days',
                            ),
                            const SizedBox(height: 20),
                            SwitchOption(
                              id: 'notify',
                              title: 'Reminders',
                              conditional: () => context
                                  .read<HabitFormCubit>()
                                  .checkHabitReminderPermissions(context),
                              onChanged: (value) {
                                if (value) {
                                  context.read<HabitFormCubit>().addReminder(
                                        DateTime.now(),
                                      );
                                } else {
                                  context
                                      .read<HabitFormCubit>()
                                      .clearReminders();
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            const HabitRemindersList(),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Button(
                        text: habit != null ? 'Update habit' : 'Create habit',
                        onTap: () => _onSubmit(context),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
