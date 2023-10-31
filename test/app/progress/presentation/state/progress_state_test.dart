import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/presentation/state/progress_state.dart';

import '../../../../utils/data.dart';

void main() {
  test('progress/presentation/state - test ProgressState equality and copy',
      () {
    final state = ProgressState(
      progress: progressEntity,
      status: ProgressStatus.loading,
      error: '',
    );

    expect(
      state,
      ProgressState(
        progress: progressEntity,
        status: ProgressStatus.loading,
        error: '',
      ),
    );
    expect(
      state.hashCode,
      ProgressState(
        progress: progressEntity,
        status: ProgressStatus.loading,
        error: '',
      ).hashCode,
    );
    expect(
      state.copyWith(),
      ProgressState(
        progress: progressEntity,
        status: ProgressStatus.loading,
        error: '',
      ),
    );

    expect(
      state.copyWith(
        progress: progressEntity,
        status: ProgressStatus.error,
        error: '',
      ),
      ProgressState(
        progress: progressEntity,
        status: ProgressStatus.error,
        error: '',
      ),
    );
  });
}
