import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/presentation/pages/habits_form_page.dart';
import 'package:habit_go/app/habits/presentation/state/habits_bloc.dart';
import 'package:habit_go/app/habits/presentation/state/habits_event.dart';
import 'package:habit_go/app/habits/presentation/state/habits_state.dart';
import 'package:habit_go/app/habits/presentation/widgets/habit_card.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/calendar/calendar_widget.dart';
import 'package:habit_go/core/widgets/errors/error_widget.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({super.key});

  @override
  State<HabitsPage> createState() => HabitsPageState();
}

class HabitsPageState extends State<HabitsPage> {
  final _calendarKey = GlobalKey<CalendarWidgetState>();
  final _calendarScroll = ScrollController();
  late PageController _controller;

  bool userScrolling = false;

  @override
  void initState() {
    _controller = PageController(
      initialPage: DateTime.now().weekday - 1,
    );
    super.initState();
  }

  void _goToDay(int day) {
    if (_controller.page == day) return;
    userScrolling = true;

    if (_controller.page!.round() < day - 1) {
      _controller.jumpToPage(day - 1);
    } else if (_controller.page!.round() > day + 1) {
      _controller.jumpToPage(day + 1);
    }

    _controller
        .animateToPage(
          day,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        )
        .then((value) => userScrolling = false);
  }

  void _onPageChanged(int index, {bool swipeRight = true}) {
    if (userScrolling) return;
    _calendarKey.currentState?.animateCalendar(right: swipeRight);

    if (index > 3 &&
        (_calendarScroll.position.pixels !=
                _calendarScroll.position.maxScrollExtent ||
            Platform.environment.containsKey('FLUTTER_TEST'))) {
      _calendarScroll.animateTo(
        _calendarScroll.position.maxScrollExtent,
        curve: Curves.ease,
        duration: const Duration(milliseconds: 300),
      );
    } else if (index <= 2 &&
        _calendarScroll.position.pixels ==
            _calendarScroll.position.maxScrollExtent) {
      _calendarScroll.animateTo(
        0,
        curve: Curves.ease,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  void _onHabitPressed({
    required BuildContext context,
    required HabitEntity habit,
    required int pageIndex,
  }) {
    context.read<HabitsBloc>().add(
          HabitProgressEvent(
            habit: habit,
            index: pageIndex,
          ),
        );
  }

  void _onHabitReset({
    required BuildContext context,
    required HabitEntity habit,
    required int pageIndex,
  }) {
    context.read<HabitsBloc>().add(
          HabitResetEvent(
            habit: habit,
            index: pageIndex,
          ),
        );
  }

  void _onHabitDelete({
    required BuildContext context,
    required HabitEntity habit,
  }) {
    context.read<HabitsBloc>().add(
          HabitDeleteEvent(habit),
        );
  }

  void _onHabitUpdate({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) {
    context.read<HabitsBloc>().add(
          HabitUpdateEvent(data),
        );
  }

  void _onHabitCreate({
    required BuildContext context,
    required Map<String, dynamic> data,
  }) {
    context.read<HabitsBloc>().add(
          HabitAddEvent(data),
        );
  }

  bool buildEntireHabitsList(HabitState previous, HabitState current) {
    return previous.status != current.status && current.updateIndex == -1;
  }

  bool buildHabit(int index, HabitState previous, HabitState current) {
    return previous.status != current.status && current.updateIndex == index;
  }

  void onHabitEvent(BuildContext context, HabitState state) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.theme.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          final data = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HabitFormPage(),
            ),
          );
          if (context.mounted) {
            _onHabitCreate(context: context, data: data);
          }
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          child: Column(
            children: [
              CalendarWidget(
                key: _calendarKey,
                scrollController: _calendarScroll,
                onItemTap: _goToDay,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<HabitsBloc, HabitState>(
                listener: onHabitEvent,
                buildWhen: buildEntireHabitsList,
                builder: (context, state) {
                  if (state.status == HabitStatus.loading) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state.status == HabitStatus.error) {
                    return Expanded(
                      child: CustomErrorWidget(
                        onTryAgain: () =>
                            context.read<HabitsBloc>().add(HabitLoadEvent()),
                      ),
                    );
                  }

                  return Expanded(
                    child: PageView.builder(
                      itemCount: 7,
                      physics: const BouncingScrollPhysics(),
                      controller: _controller,
                      onPageChanged: (value) => _onPageChanged(
                        value,
                        swipeRight: _controller.position.userScrollDirection !=
                            ScrollDirection.reverse,
                      ),
                      itemBuilder: (context, pageIndex) {
                        return ListView.builder(
                          itemCount: state.habits.length,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          itemBuilder: (context, index) {
                            final habit = state.habits[index];
                            return BlocBuilder<HabitsBloc, HabitState>(
                              // coverage:ignore-start
                              buildWhen: (previous, current) =>
                                  buildHabit(index, previous, current),
                              // coverage:ignore-end
                              builder: (context, snapshot) {
                                return HabitCard(
                                  habit,
                                  show: habit.progress[pageIndex] >= 0,
                                  index: pageIndex,
                                  onPressed: () => _onHabitPressed(
                                    context: context,
                                    habit: state.habits[index],
                                    pageIndex: pageIndex,
                                  ),
                                  onClosed: (data) {
                                    switch (data['result']) {
                                      case 'update':
                                        _onHabitUpdate(
                                          context: context,
                                          data: data,
                                        );
                                        break;
                                      case 'delete':
                                        _onHabitDelete(
                                          context: context,
                                          habit: habit,
                                        );
                                        break;
                                      case 'reset':
                                        _onHabitReset(
                                          context: context,
                                          habit: habit,
                                          pageIndex: pageIndex,
                                        );
                                        break;
                                      default:
                                        break;
                                    }
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
