class TaskModel {
  final String id;
  final String title;
  final DateTime? date;
  final String? time;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    this.date,
    this.time,
    required this.isCompleted,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      date: map['task_date'] != null ? DateTime.parse(map['task_date']) : null,
      time: map['task_time'],
      isCompleted: map['is_completed'] ?? false,
    );
  }
}
