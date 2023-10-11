import 'package:habit_go/app/progress/data/datasources/progress_datasource.dart';
import 'package:habit_go/app/progress/data/models/progress_model.dart';
import 'package:habit_go/app/progress/domain/entities/progress_entity.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

class ProgressRepositoryImpl extends ProgressRepository {
  final ProgressDatasource progressDatasource;

  ProgressRepositoryImpl({required this.progressDatasource});

  @override
  Future<Result<bool>> resetProgress() {
    return _handle<bool>(() async {
      await progressDatasource.resetProgress();
      return Result.success(true);
    });
  }

  @override
  Future<Result<ProgressEntity>> getProgress() {
    return _handle<ProgressEntity>(() async {
      final result = await progressDatasource.getProgress();
      if (result == null) {
        return Result.failure(const NoDataFailure());
      }
      return Result.success(result.toEntity());
    });
  }

  @override
  Future<Result<ProgressEntity>> saveProgress(ProgressEntity progress) {
    return _handle<ProgressEntity>(() async {
      final result = await progressDatasource.saveProgress(
        ProgressModel.fromEntity(progress),
      );
      return Result.success(result.toEntity());
    });
  }

  Future<Result<T>> _handle<T>(Function f) async {
    try {
      return await f();
    } on RangeError catch (_) {
      return Result.failure(const CorruptedDataFailure());
    } on DatabaseIndexError catch (_) {
      return Result.failure(const DatabaseFailure());
    } on DatabaseError catch (_) {
      return Result.failure(const DatabaseFailure());
    } catch (e) {
      return Result.failure(const Failure());
    }
  }
}
