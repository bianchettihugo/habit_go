// coverage:ignore-file

import 'package:flutter/foundation.dart';
import 'package:habit_go/app/progress/data/datasources/progress_datasource.dart';
import 'package:habit_go/app/progress/data/datasources/progress_datasource.local.dart';
import 'package:habit_go/app/progress/data/repositories/progress_repository_impl.dart';
import 'package:habit_go/app/progress/domain/repositories/progress_repository.dart';
import 'package:habit_go/app/progress/domain/usecases/get_progress_usecase.dart';
import 'package:habit_go/app/progress/domain/usecases/reset_progress_usecase.dart';
import 'package:habit_go/app/progress/domain/usecases/save_progress_usecase.dart';
import 'package:habit_go/app/progress/domain/usecases/update_actions_done_usecase.dart';
import 'package:habit_go/app/progress/domain/usecases/update_total_actions_usecase.dart';
import 'package:isar/isar.dart';

import '../../core/services/dependency/dependency_service.dart';

class ProgressModule {
  static void init() {
    Dependency.register<ProgressDatasource>(
      LocalProgressDatasource(
        isar: Dependency.get<Isar>(),
      ),
    );

    Dependency.register<ProgressRepository>(
      ProgressRepositoryImpl(
        progressDatasource: Dependency.get<ProgressDatasource>(),
      ),
    );

    Dependency.register<GetProgressUsecase>(
      GetProgressUsecaseImpl(
        repository: Dependency.get<ProgressRepository>(),
      ),
    );

    Dependency.register<SaveProgressUsecase>(
      SaveProgressUsecaseImpl(
        repository: Dependency.get<ProgressRepository>(),
      ),
    );

    Dependency.register<ResetProgressUsecase>(
      ResetProgressUsecaseImpl(
        repository: Dependency.get<ProgressRepository>(),
      ),
    );

    Dependency.register<UpdateActionsDoneUsecase>(
      UpdateActionsDoneUsecaseImpl(
        repository: Dependency.get<ProgressRepository>(),
      ),
    );

    Dependency.register<UpdateTotalActionsUsecase>(
      UpdateTotalActionsUsecaseImpl(
        repository: Dependency.get<ProgressRepository>(),
      ),
    );

    if (kDebugMode) print('\x1B[36m-==== PROGRESS MODULE INITIALIZED ====-');
  }
}
