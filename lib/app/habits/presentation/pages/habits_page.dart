import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:habit_go/core/utils/extensions.dart';
import 'package:habit_go/core/widgets/calendar/calendar_widget.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({super.key});

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
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
        _calendarScroll.position.pixels !=
            _calendarScroll.position.maxScrollExtent) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.theme.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {},
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
              Expanded(
                child: PageView.builder(
                  itemCount: 7,
                  physics: const BouncingScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (value) => _onPageChanged(
                    value,
                    swipeRight: _controller.position.userScrollDirection !=
                        ScrollDirection.reverse,
                  ),
                  itemBuilder: (context, index) {
                    return Center(
                      child: Text('Page $index'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
