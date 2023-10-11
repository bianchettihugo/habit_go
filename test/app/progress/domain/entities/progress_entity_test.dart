import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';

import '../../../../utils/data.dart';

void main() {
  final entity = ProgressEntity(
    doneActions: [2, 1],
    totalActions: [3, 3],
  );

  test('progress/domain/entities - should create a new entity', () async {
    expect(entity, progressEntity);
    expect(entity.hashCode, progressEntity.hashCode);
  });

  test('progress/domain/entities - should create a copy of an entity',
      () async {
    expect(entity.copyWith(), progressEntity);
    expect(
      entity.copyWith(totalActions: [4, 4]),
      ProgressEntity(
        doneActions: [2, 1],
        totalActions: [4, 4],
      ),
    );
    expect(
      entity.copyWith(doneActions: [3, 3], totalActions: [4, 4]),
      ProgressEntity(
        doneActions: [3, 3],
        totalActions: [4, 4],
      ),
    );
  });
}
