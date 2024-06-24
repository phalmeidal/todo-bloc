import 'package:todo_bloc/app/data/models/task_model.dart';

class TaskRepository {
  final List<TaskModel> _tasks = [];

  Future<List<TaskModel>> getTasks() async {
    _tasks.addAll([
      TaskModel(title: 'Compras no mercado'),
      TaskModel(title: 'Fazer exercícios'),
      TaskModel(title: 'Task 3'),
    ]);

    return Future.delayed(
      const Duration(seconds: 1),
      () => _tasks,
    );
  }

  Future<List<TaskModel>> postTask({required TaskModel task}) async {
    _tasks.add(task);

    return Future.delayed(
      const Duration(seconds: 1),
      () => _tasks,
    );
  }

  Future<List<TaskModel>> deleteTask({required TaskModel task}) async {
    _tasks.remove(task);

    return Future.delayed(
      const Duration(seconds: 1),
      () => _tasks,
    );
  }
}
