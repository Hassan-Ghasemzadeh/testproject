import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/task.dart';
import '../blocs/bloc/tasks_bloc.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = tasks[index];
        return Dismissible(
          key: Key(task.title),
          onDismissed: (direction) {
            context.read<TasksBloc>().add(DeleteTask(task: task));

            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${task.title} dismissed')));
          },
          child: ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            trailing: Checkbox(
              onChanged: (value) {
                context.read<TasksBloc>().add(ToggleCheckBox(task: task));
              },
              value: task.isDone,
            ),
          ),
        );
      },
    ));
  }
}
