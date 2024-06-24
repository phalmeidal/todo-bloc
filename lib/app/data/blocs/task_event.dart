import 'package:todo_bloc/app/data/models/task_model.dart';

abstract class TaskEvent {}

class GetTasks extends TaskEvent {}

class PostTasks extends TaskEvent {
  final TaskModel task;

  PostTasks({required this.task});
}

class DeleteTasks extends TaskEvent {
  final TaskModel task;

  DeleteTasks({required this.task});
}
