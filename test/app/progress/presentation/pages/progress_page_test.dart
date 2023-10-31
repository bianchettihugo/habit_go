import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/app/progress/presentation/pages/progress_page.dart';
import 'package:habit_go/app/progress/presentation/state/progress_bloc.dart';
import 'package:habit_go/app/progress/presentation/state/progress_state.dart';
import 'package:habit_go/core/widgets/buttons/link_button.dart';
import 'package:habit_go/core/widgets/errors/error_widget.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../utils/mocks.dart';

void main() {
  late ProgressBloc progressBloc;

  setUp(() {
    progressBloc = MockProgressBloc();
  });

  tearDown(() {
    progressBloc.close();
  });

  testWidgets(
      'progress/presentation/pages - renders CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(() => progressBloc.state)
        .thenReturn(ProgressState(status: ProgressStatus.loading));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: progressBloc,
          child: const ProgressPage(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'progress/presentation/pages - renders CustomErrorWidget when error',
      (WidgetTester tester) async {
    when(() => progressBloc.state)
        .thenReturn(ProgressState(status: ProgressStatus.error));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: progressBloc,
          child: const ProgressPage(),
        ),
      ),
    );

    expect(find.byType(CustomErrorWidget), findsOneWidget);

    await tester.tap(find.byType(LinkButton));
  });

  testWidgets('progress/presentation/pages - renders Table when success',
      (WidgetTester tester) async {
    when(() => progressBloc.state).thenReturn(
      ProgressState(
        status: ProgressStatus.loaded,
        progress: ProgressEntity(
          doneActions: List.generate(31, (index) => 1),
          totalActions: List.generate(7, (index) => 1),
        ),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: progressBloc,
          child: const ProgressPage(),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(Table), findsOneWidget);
  });

  testWidgets(
      'progress/presentation/pages - renders Table with correct opacity colors',
      (WidgetTester tester) async {
    final progressState = ProgressState(
      status: ProgressStatus.loaded,
      progress: ProgressEntity(
        doneActions: List.generate(31, (index) => index.isEven ? 1 : 0),
        totalActions: List.generate(7, (index) => 2),
      ),
    );
    when(() => progressBloc.state).thenReturn(progressState);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: progressBloc,
          child: const ProgressPage(),
        ),
      ),
    );

    final table = tester.widget<Table>(find.byType(Table));
    final rows = table.children;
    var count = 1;

    expect(rows.length, 6);

    for (var i = 0; i < rows.length; i++) {
      final row = rows[i];
      final cells = row.children;

      expect(cells.length, 7);

      for (var j = 0; j < cells.length; j++) {
        final cell = cells[j];

        final opacity = cell is Container && cell.decoration != null
            ? (cell.decoration! as BoxDecoration).color?.opacity ?? 0
            : 1;

        if (i == 0) {
          expect((cell as Container).child, isA<Text>());
        } else if (opacity != 1 &&
            count < 30 &&
            progressState.progress.doneActions[count] != 0) {
          final expectedOpacity = progressState.progress.doneActions[count] /
              progressState.progress.totalActions[j];
          expect(
            double.parse(opacity.toStringAsFixed(2)),
            equals(expectedOpacity),
          );
        }
        count++;
      }
    }
  });
}
