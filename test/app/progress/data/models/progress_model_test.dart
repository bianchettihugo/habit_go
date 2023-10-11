import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/data/models/progress_model.dart';

import '../../../../utils/data.dart';

void main() {
  final model = ProgressModel(
    doneActions: [2, 1],
    totalActions: [3, 3],
  );

  test('progress/data/models - should create a new model', () async {
    expect(model, progressModel);
    expect(model.hashCode, progressModel.hashCode);
  });

  test('progress/data/models - should create a new model from an entity',
      () async {
    expect(ProgressModel.fromEntity(progressEntity), progressModel);
  });

  test('progress/data/models - should create an entity from a model', () async {
    expect(model.toEntity(), progressEntity);
  });
}
