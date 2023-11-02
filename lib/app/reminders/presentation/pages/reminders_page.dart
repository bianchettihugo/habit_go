import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_bloc.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_events.dart';
import 'package:habit_go/app/reminders/presentation/state/reminders_state.dart';
import 'package:habit_go/app/reminders/presentation/widgets/reminder_card.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/errors/error_widget.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Reminders',
          style: context.text.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<RemindersBloc, ReminderState>(
          builder: (context, state) {
            if (state.status == ReminderStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ReminderStatus.error) {
              return CustomErrorWidget(
                onTryAgain: () =>
                    context.read<RemindersBloc>().add(ReminderLoadEvent()),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: 20),
                itemCount: state.reminders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ReminderCard(
                      reminder: state.reminders[index],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
