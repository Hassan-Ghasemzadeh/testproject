// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

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
    log('built');
    return ListWidget(
      tasks: tasks,
    );
  }
}

class ListWidget extends StatefulWidget {
  final List<Task> tasks;

  const ListWidget({
    Key? key,
    required this.tasks,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ListViewState();
  }
}

class _ListViewState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        var task = widget.tasks[index];

        return Dismissible(
          key: Key(task.title),
          onDismissed: (direction) {
            context.read<TasksBloc>().add(DeleteTask(task: task));

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${task.title} dismissed')));
          },
          child: ListTile(
            title: Text(
              task.title,
              style: TextStyle(decoration: task.isDone! ? TextDecoration.lineThrough : TextDecoration.none),
            ),
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
