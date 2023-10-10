import 'package:isar/isar.dart';

typedef DatabaseError = IsarError;
typedef DatabaseIndexError = IsarUniqueViolationError;

class Failure {
  final String message;
  final String module;
  final int statusCode;

  const Failure({
    this.message = '',
    this.module = '',
    this.statusCode = 0,
  });

  @override
  bool operator ==(covariant Failure other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.module == module &&
        other.statusCode == statusCode;
  }

  @override
  int get hashCode => message.hashCode ^ module.hashCode ^ statusCode.hashCode;
}

class DatabaseFailure extends Failure {
  const DatabaseFailure();
}

class CorruptedDataFailure extends Failure {
  const CorruptedDataFailure();
}
