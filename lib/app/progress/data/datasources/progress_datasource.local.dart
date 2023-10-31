import 'package:habit_go/app/progress/data/datasources/progress_datasource.dart';
import 'package:habit_go/app/progress/data/models/progress_model.dart';
import 'package:isar/isar.dart';

class LocalProgressDatasource extends ProgressDatasource {
  final Isar _isar;

  LocalProgressDatasource({
    required Isar isar,
  }) : _isar = isar;

  @override
  Future<ProgressModel> saveProgress(ProgressModel progress) async {
    await _isar.writeTxn(() async {
      return _isar.progressModels.put(progress);
    });

    return progress;
  }

  @override
  Future<ProgressModel?> getProgress() async {
    ProgressModel? item;
    await _isar.txn(() async {
      item = await _isar.progressModels.where().findFirst();
    });

    if (item == null) {
      await _isar.writeTxn(() async {
        await _createProgress();
        item = await _isar.progressModels.where().findFirst();
      });
    }

    return item;
  }

  Future<void> _clearProgress() async {
    return _isar.progressModels.clear();
  }

  Future<int> _createProgress() async {
    return _isar.progressModels.put(
      ProgressModel(
        doneActions: List.generate(31, (index) => 0),
        totalActions: List.generate(7, (index) => 1),
      ),
    );
  }

  @override
  Future<ProgressModel> resetProgress() async {
    await _isar.writeTxn(() async {
      await _clearProgress();
      await _createProgress();
    });
    return ProgressModel(
      doneActions: List.generate(31, (index) => 0),
      totalActions: List.generate(7, (index) => 1),
    );
  }
}
