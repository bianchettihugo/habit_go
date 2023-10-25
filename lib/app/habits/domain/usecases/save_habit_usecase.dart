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
      data['id'] == null || int.tryParse(data['id'].toString()) != null,
      data['name'] != null && data['name'].toString().isNotEmpty,
      data['repeat'] != null && int.tryParse(data['repeat'].toString()) != null,
      data['days'] != null && data['days'] is List<int>,
      data['notify'] != null && data['notify'] is bool,
      data['type'] != null && data['type'] is Map,
      data['type'] is Map && data['type'].containsKey('icon'),
    ];

    if (rules.contains(false)) {
      return Result.failure(const InvalidDataFailure());
    }

    final id = int.tryParse(data['id']?.toString() ?? '');
    final habit = HabitEntity(
      id: id,
      title: data['name'].toString(),
      repeat: int.tryParse(data['repeat'].toString()) ?? 1,
      originalProgress: data['days'],
      progress: data['days'],
      reminder: data['notify'],
      icon: data['type']['icon'].toString(),
      color: 'primary',
    );

    return id != null
        ? _repository.updateHabit(habit)
        : _repository.createHabit(habit);
  }
}
