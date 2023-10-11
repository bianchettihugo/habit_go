import 'package:habit_go/app/progress/data/models/progress_model.dart';

abstract class ProgressDatasource {
  Future<ProgressModel?> getProgress();

  Future<ProgressModel> saveProgress(ProgressModel progress);

  Future<void> resetProgress();
}
