import 'package:habit_go/app/habits/domain/entities/habit_entity.dart';
import 'package:habit_go/app/habits/domain/repositories/habit_repository.dart';
import 'package:habit_go/core/utils/failure.dart';
import 'package:habit_go/core/utils/result.dart';

abstract class SaveHabitUsecase {
  Future<Result<HabitEntity>> call({
    required Map<String, dynamic> data,
  });
}

class SaveHabitUsecaseImpl extends SaveHabitUsecase {
  final HabitRepository _repository;

  SaveHabitUsecaseImpl({required HabitRepository repository})
      : _repository = repository;

  @override
  Future<Result<HabitEntity>> call({
    required Map<String, dynamic> data,
  }) async {
    final rules = [
      data['id'] == null || int.tryParse(data['id']) != null,
      data['name'] != null && data['name'].toString().isNotEmpty,
      data['repeat'] != null && int.tryParse(data['repeat']) != null,
      data['days'] != null && data['days'] is List<int>,
      data['notify'] != null && data['notify'] is bool,
      data['type'] != null && data['type'] is Map,
      data['type'] is Map && data['type'].containsKey('icon'),
      data['type'] is Map && data['type'].containsKey('color'),
    ];

    if (rules.contains(false)) {
      return Result.failure(const InvalidDataFailure());
    }

    final habit = HabitEntity(
      id: int.tryParse(data['id']),
      title: data['name'].toString(),
      repeat: int.tryParse(data['repeat']) ?? 1,
      progress: data['days'],
      reminder: data['notify'],
      icon: data['type']['icon'].toString(),
      color: data['type']['color'].toString(),
    );

    return _repository.createHabit(habit);
  }
}
