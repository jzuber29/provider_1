import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TaskProvider>(); // shorthand watch

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Insights"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<TaskProvider>().loadTasks(), // shorthand read
          ),
        ],
      ),
      body: provider.tasks.isEmpty
          ? const Center(child: Text("No tasks yet!"))
          : ListView.builder(
              itemCount: provider.tasks.length,
              itemBuilder: (_, i) {
                final task = provider.tasks[i];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Selector<TaskProvider, bool>(
                    selector: (_, p) => p.tasks[i].isDone,
                    builder: (_, isDone, __) => Checkbox(
                      value: isDone,
                      onChanged: (_) => context.read<TaskProvider>().toggleTask(i),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddTaskScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
