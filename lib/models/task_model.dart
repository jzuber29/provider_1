class TaskModel {
  final String title;
  final String description;
  final bool isDone;

  const TaskModel({
    required this.title,
    required this.description,
    this.isDone = false,
  });

  TaskModel copyWith({String? title, String? description, bool? isDone}) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }
}
