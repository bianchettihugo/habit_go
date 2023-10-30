import 'package:flutter_test/flutter_test.dart';
import 'package:habit_go/app/progress/data/datasources/progress_datasource.dart';
import 'package:habit_go/app/progress/data/datasources/progress_datasource.local.dart';
import 'package:habit_go/app/progress/data/models/progress_model.dart';
import 'package:isar/isar.dart';

import '../../../../utils/data.dart';

void main() {
  late Isar isar;
  late ProgressDatasource datasource;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
    isar = await Isar.open([ProgressModelSchema], directory: '');
    datasource = LocalProgressDatasource(isar: isar);
  });

  test('progress/data/datasources - should create a progress', () async {
    final result = await datasource.saveProgress(progressModel);
    final habit = await isar.txn(() async {
      return isar.progressModels.where().idEqualTo(0).findFirst();
    });
    expect(result, progressModel);
    expect(habit, progressModel);
  });

  test('progress/data/datasources - should get the progress', () async {
    await datasource.saveProgress(progressModel);
    await datasource.saveProgress(progressModel);
    final result = await datasource.getProgress();
    expect(result, progressModel);
  });

  test('progress/data/datasources - should reset the progress', () async {
    await datasource.saveProgress(progressModel);
    await datasource.resetProgress();
    final result = await datasource.getProgress();
    expect(
      result,
      ProgressModel(
        doneActions: List.generate(31, (index) => 0),
        totalActions: List.generate(7, (index) => 1),
      ),
    );
  });

  tearDownAll(() {
    isar.close(deleteFromDisk: true);
  });
}
