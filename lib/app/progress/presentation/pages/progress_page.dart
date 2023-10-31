import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/progress/presentation/state/progress_bloc.dart';
import 'package:habit_go/app/progress/presentation/state/progress_event.dart';
import 'package:habit_go/app/progress/presentation/state/progress_state.dart';
import 'package:habit_go/app/progress/presentation/widgets/progress_card.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/errors/error_widget.dart';
import 'package:habit_go/core/widgets/icons/feather_icons_icons.dart';

import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  int totalActions = 0;
  int doneActions = 0;
  int completeDays = 0;
  int daysStreak = 0;

  List<TableRow> _getDays(BuildContext context, ProgressState state) {
    totalActions = doneActions = completeDays = daysStreak = 0;
    final rows = <TableRow>[];
    final columns = <Widget>[];
    var count = 0;
    var streak = 0;

    for (var i = 0; i < 36; i++) {
      if (count == 7) {
        rows.add(
          TableRow(
            children: [...columns],
          ),
        );
        columns.clear();
        count = 0;
      }

      final progress = i <= 29 ? state.progress.doneActions[i + 1] : 0;
      final total = state.progress.totalActions[count];
      final opacity = progress / total;

      totalActions += total;
      doneActions += progress;

      if (opacity == 1) {
        completeDays++;
        streak++;
        if (streak > daysStreak) {
          daysStreak = streak;
        }
      } else {
        streak = 0;
      }

      columns.add(
        Container(
          width: 32,
          height: 36,
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: progress == 0 || total <= 0
                ? context.theme.canvasColor
                : context.theme.primaryColor.withOpacity(opacity),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
      count++;
    }

    return rows;
  }

  int _getDaysInMonth() {
    final now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0).day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          '${DateFormat("MMMM").format(DateTime.now())} progress',
          style: context.text.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ProgressBloc, ProgressState>(
          builder: (context, state) {
            if (state.status == ProgressStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ProgressStatus.error) {
              return CustomErrorWidget(
                onTryAgain: () =>
                    context.read<ProgressBloc>().add(const ProgressLoadEvent()),
              );
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Table(
                        key: UniqueKey(),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(42),
                          1: FixedColumnWidth(42),
                          2: FixedColumnWidth(42),
                          3: FixedColumnWidth(42),
                          4: FixedColumnWidth(42),
                          5: FixedColumnWidth(42),
                          6: FixedColumnWidth(42),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.bottom,
                        children: <TableRow>[
                          TableRow(
                            children: <Widget>[
                              ...List.generate(
                                7,
                                (index) {
                                  final date = DateTime.now();
                                  final now = DateTime(
                                    date.year,
                                    date.month,
                                    date.day - (date.weekday - 1),
                                  );

                                  return Container(
                                    width: 32,
                                    height: 36,
                                    margin: const EdgeInsets.only(right: 2.5),
                                    child: Text(
                                      intl.DateFormat('EEEE')
                                          .format(
                                            now.add(Duration(days: index)),
                                          )
                                          .substring(0, 1)
                                          .toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: context.text.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          ..._getDays(context, state),
                        ],
                      ),
                      const SizedBox(height: 50),
                      ProgressCard(
                        value: doneActions,
                        total: totalActions,
                        icon: FeatherIcons.fi_check_circle,
                        title: 'Actions done',
                        description: 'How many actions you have done',
                      ),
                      const SizedBox(height: 20),
                      ProgressCard(
                        value: completeDays,
                        total: _getDaysInMonth(),
                        icon: FeatherIcons.fi_calendar,
                        title: 'Days completed',
                        description: 'How many days you have completed',
                      ),
                      const SizedBox(height: 20),
                      ProgressCard(
                        value: daysStreak,
                        total: _getDaysInMonth(),
                        icon: FeatherIcons.fi_activity,
                        title: 'Days streak',
                        description: 'How many days completed in a row',
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
