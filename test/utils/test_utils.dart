import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/core/themes/light_theme.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

final mockObserver = MockNavigatorObserver();

extension WidgetTesterConfig on WidgetTester {
  Future<void> pumpWidgetWithApp(
    Widget widget, {
    Locale locale = const Locale('en'),
  }) async {
    registerFallbackValue(
      MaterialPageRoute(builder: (c) => const Center()),
    );

    await pumpWidget(
      MaterialApp(
        navigatorObservers: [mockObserver],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('pt'),
          Locale('en'),
        ],
        locale: locale,
        theme: LightTheme().theme,
        home: Builder(
          builder: (context) {
            return Scaffold(body: widget);
          },
        ),
      ),
    );
  }
}
