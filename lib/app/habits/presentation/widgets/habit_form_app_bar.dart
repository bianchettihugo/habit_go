import 'package:flutter/material.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/core/utils/dialogs.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';

class HabitFormAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HabitEntity? habit;
  final int index;

  const HabitFormAppBar({
    required this.habit,
    this.index = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        habit != null ? 'Edit habit' : 'New habit',
        style: context.text.bodyLarge,
      ),
      actions: habit != null
          ? [
              IconButton(
                icon: const Icon(FeatherIcons.fi_refresh_cw),
                onPressed: () async {
                  final confirmation = await Dialogs.showConfirmationDialog(
                    context: context,
                    title: 'Reset habit',
                    continueText: 'Reset',
                    description:
                        'This will reset all the progress made on this day. '
                        'Continue?',
                  );
                  if (confirmation && context.mounted) {
                    Navigator.pop(context, {'result': 'reset'});
                  }
                },
              ),
              IconButton(
                icon: Icon(
                  FeatherIcons.fi_delete,
                  color: context.theme.primaryColor,
                ),
                onPressed: () async {
                  final confirmation = await Dialogs.showConfirmationDialog(
                    context: context,
                    title: 'Delete habit',
                    continueText: 'Delete',
                    description: 'This will delete this task on all days. '
                        "This action canno't be undone. Continue?",
                  );
                  if (confirmation && context.mounted) {
                    Navigator.pop(context, {'result': 'delete'});
                  }
                },
              ),
              const SizedBox(width: 5),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
