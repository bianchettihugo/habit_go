class ReminderEntity {
  final int id;
  final DateTime time;
  final String title;
  final bool enabled;

  const ReminderEntity({
    required this.time,
    required this.title,
    this.id = 0,
    this.enabled = true,
  });

  @override
  bool operator ==(covariant ReminderEntity other) {
    if (identical(this, other)) return true;

    return other.time == time &&
        other.title == title &&
        other.enabled == enabled &&
        other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ enabled.hashCode ^ id.hashCode;

  ReminderEntity copyWith({
    int? id,
    DateTime? time,
    String? title,
    bool? enabled,
  }) {
    return ReminderEntity(
      time: time ?? this.time,
      title: title ?? this.title,
      enabled: enabled ?? this.enabled,
      id: id ?? this.id,
    );
  }
}
