import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/presentation/state/progress_event.dart';

void main() {
  test('progress/presentation/state - ProgressLoadEvent equality test',
      () async {
    const loadEvent = ProgressLoadEvent();

    expect(loadEvent, const ProgressLoadEvent());
    expect(loadEvent.hashCode, const ProgressLoadEvent().hashCode);
    expect(loadEvent.props, const ProgressLoadEvent().props);
  });

  test('progress/presentation/state - ProgressActionEvent equality test',
      () async {
    const actionEvent = ProgressActionEvent(index: 0, value: 1);

    expect(actionEvent, const ProgressActionEvent(index: 0, value: 1));
    expect(
      actionEvent.hashCode,
      const ProgressActionEvent(index: 0, value: 1).hashCode,
    );
    expect(
      actionEvent.props,
      const ProgressActionEvent(index: 0, value: 1).props,
    );
  });

  test('progress/presentation/state - ProgressUpdateEvent equality test',
      () async {
    const updateEvent = ProgressUpdateEvent(
      progress: [1, 2, 3],
      repeat: 1,
      oldProgress: [1, 2, 3],
      oldRepeat: 1,
    );

    expect(
      updateEvent,
      const ProgressUpdateEvent(
        progress: [1, 2, 3],
        repeat: 1,
        oldProgress: [1, 2, 3],
        oldRepeat: 1,
      ),
    );
    expect(
      updateEvent.hashCode,
      const ProgressUpdateEvent(
        progress: [1, 2, 3],
        repeat: 1,
        oldProgress: [1, 2, 3],
        oldRepeat: 1,
      ).hashCode,
    );
    expect(
      updateEvent.props,
      const ProgressUpdateEvent(
        progress: [1, 2, 3],
        repeat: 1,
        oldProgress: [1, 2, 3],
        oldRepeat: 1,
      ).props,
    );
  });

  test('progress/presentation/state - ProgressResetEvent equality test',
      () async {
    const resetEvent = ProgressResetEvent();

    expect(resetEvent, const ProgressResetEvent());
    expect(resetEvent.hashCode, const ProgressResetEvent().hashCode);
    expect(resetEvent.props, const ProgressResetEvent().props);
  });
}
