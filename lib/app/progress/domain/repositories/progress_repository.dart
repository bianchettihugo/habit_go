import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class ProgressRepository {
  Future<Result<ProgressEntity>> saveProgress(ProgressEntity progress);
  Future<Result<ProgressEntity>> getProgress();
  Future<Result<bool>> resetProgress();
}
