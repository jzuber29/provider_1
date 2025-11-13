import 'dart:async';
import 'dart:isolate';
import 'package:tuple/tuple.dart';
import '../models/task_model.dart';

class TaskService {
  // Simulate fetching tasks asynchronously
  Future<List<TaskModel>> fetchTasks() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      return [
        TaskModel(title: "Study Flutter", description: "3 hours of practice"),
        TaskModel(title: "Team Meeting", description: "At 4 PM"),
      ];
    });
  }

  // Example of using isolate for heavy computation
  static void _heavyTask(SendPort sendPort) {
    final total = List.generate(5000, (i) => i).reduce((a, b) => a + b);
    sendPort.send(total);
  }

  Future<Tuple2<List<TaskModel>, int>> loadDataWithIsolate() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(_heavyTask, receivePort.sendPort);
    final sum = await receivePort.first as int;

    final tasks = await fetchTasks();
    return Tuple2(tasks, sum);
  }
}
