class WorkoutTask {
  final int id;
  final String name;
  final String workoutType;
  final DateTime scheduledAt;
  bool isDone;

  WorkoutTask({
    required this.id,
    required this.name,
    required this.workoutType,
    required this.scheduledAt,
    this.isDone = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'workoutType': workoutType,
    'scheduledAt': scheduledAt.toIso8601String(), 'isDone': isDone,
  };

  factory WorkoutTask.fromJson(Map<String, dynamic> j) => WorkoutTask(
    id: j['id'], name: j['name'],
    workoutType: j['workoutType'] ?? 'Workout',
    scheduledAt: DateTime.parse(j['scheduledAt']),
    isDone: j['isDone'] ?? false,
  );
}