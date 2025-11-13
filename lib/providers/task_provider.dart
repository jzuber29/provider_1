import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _service = TaskService();
  List<TaskModel> _tasks = [];
  int _computedValue = 0;

  List<TaskModel> get tasks => _tasks;
  int get computedValue => _computedValue;

  Future<void> loadTasks() async {
    final Tuple2<List<TaskModel>, int> result = await _service.loadDataWithIsolate();
    _tasks = result.item1;
    _computedValue = result.item2;
    notifyListeners();
  }

  void addTask(TaskModel task) {
    _tasks.add(task);
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index] = _tasks[index].copyWith(isDone: !_tasks[index].isDone);
    notifyListeners();
  }
}
