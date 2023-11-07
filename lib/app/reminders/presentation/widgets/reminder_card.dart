import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/reminders/domain/entities/reminder_entity.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_bloc.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_events.dart';
import 'package:habit_go/core/utils/dialogs.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';
import 'package:intl/intl.dart' as intl;

class ReminderCard extends StatelessWidget {
  final ReminderEntity reminder;

  const ReminderCard({
    required this.reminder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                FeatherIcons.fi_bell,
                color: context.theme.primaryColor,
              ),
            ),
          ),
        ),
        tileColor: context.theme.canvasColor,
        title: Row(
          children: [
            Text(
              reminder.title,
              style: context.text.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' - ${_format(reminder.time)}',
              style: context.text.bodySmall,
            ),
          ],
        ),
        subtitle: Wrap(
          children: List.generate(7, (index) {
            final date = DateTime.now();
            final initialDate = DateTime(
              date.year,
              date.month,
              date.day - (date.weekday - 1),
            );
            final now = initialDate.add(Duration(days: index));
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Text(
                intl.DateFormat('EEEE')
                    .format(now)
                    .substring(0, 1)
                    .toUpperCase(),
                style: context.text.bodyMedium?.copyWith(
                  fontWeight:
                      reminder.days[index] >= 0 ? FontWeight.bold : null,
                  color: reminder.days[index] >= 0
                      ? context.theme.colorScheme.onSurface
                      : context.themeColors.grey,
                ),
              ),
            );
          }),
        ),
        trailing: IconButton(
          icon: const Icon(FeatherIcons.fi_delete),
          color: context.theme.colorScheme.onSurface,
          onPressed: () async {
            final confirmation = await Dialogs.showConfirmationDialog(
              context: context,
              title: 'Delete reminder',
              continueText: 'Delete',
              description: 'This will delete this reminder. '
                  "This action canno't be undone. Continue?",
            );
            if (confirmation && context.mounted) {
              context.read<RemindersBloc>().add(
                    ReminderDeleteEvent(reminder),
                  );
            }
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
      ),
    );
  }

  String _format(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
