import 'package:flutter/material.dart';
import 'package:habit_go/core/themes/light_theme.dart';
import 'package:habit_go/core/widgets/calendar/calendar_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: LightTheme().theme,
      home: const TestWidget(),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CalendarItem(
                date: DateTime.now(),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
