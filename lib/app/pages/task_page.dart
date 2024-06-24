import 'package:flutter/material.dart';
import 'package:todo_bloc/app/data/blocs/task_bloc.dart';
import 'package:todo_bloc/app/data/blocs/task_event.dart';
import 'package:todo_bloc/app/data/blocs/task_state.dart';

import '../data/models/task_model.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final TaskBloc _taskBloc;

  @override
  void initState() {
    super.initState();
    _taskBloc = TaskBloc();
    _taskBloc.inputTask.add(GetTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      body: StreamBuilder<TaskState>(
          stream: _taskBloc.outputTask,
          builder: (context, state) {
            if (state.data is TaskLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.data is TaskLoadedState) {
              final list = state.data?.tasks ?? [];
              return ListView.separated(
                separatorBuilder: (_, __) => const Divider(),
                itemCount: list.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Center(
                        child: Text(
                          list[index].title[0],
                        ),
                      ),
                    ),
                    title: Text(list[index].title),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _taskBloc.inputTask.add(
                          DeleteTasks(task: list[index]),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _taskBloc.inputTask.add(
            PostTasks(
              task: TaskModel(
                title: 'Nova tarefa',
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _taskBloc.inputTask.close();
    super.dispose();
  }
}
