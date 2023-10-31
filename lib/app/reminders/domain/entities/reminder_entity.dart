class ReminderEntity {
  final DateTime time;
  final String title;

  const ReminderEntity({
    required this.time,
    required this.title,
  });

  @override
  bool operator ==(covariant ReminderEntity other) {
    if (identical(this, other)) return true;

    return other.time == time && other.title == title;
  }

  @override
  int get hashCode => title.hashCode;

  ReminderEntity copyWith({
    DateTime? time,
    String? title,
  }) {
    return ReminderEntity(
      time: time ?? this.time,
      title: title ?? this.title,
    );
  }
}
