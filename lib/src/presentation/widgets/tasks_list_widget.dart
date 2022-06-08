// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/src/core/method_channel_utils.dart';
import 'package:testproject/src/data/models/task_category.dart';
import 'package:testproject/src/domain/entities/task_entity.dart';

import '../../core/utils/bottom_sheet.dart';
import '../../data/models/task.dart';
import '../blocs/bloc/tasks_bloc.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.categorys,
    required this.filteredTaskList,
  }) : super(key: key);

  final List<Task> filteredTaskList;
  final List<Category> categorys;
  @override
  Widget build(BuildContext context) {
    return ListWidget(
      categorys: categorys,
      filteredTaskList: filteredTaskList,
    );
  }
}

class ListWidget extends StatefulWidget {
  final List<Task> filteredTaskList;
  final List<Category> categorys;
  const ListWidget({
    Key? key,
    required this.categorys,
    required this.filteredTaskList,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ListViewState();
  }
}

class _ListViewState extends State<ListWidget> {
  @override
  void initState() {
    super.initState();
  }

  void showsnackbar(String message, context) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    List<Category> filteredCategory = widget.categorys;
    return Expanded(
        child: ListView.builder(
      itemCount: widget.filteredTaskList.length,
      itemBuilder: (context, index) {
        var task = widget.filteredTaskList[index];
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            context.read<TasksBloc>().add(DeleteTask(task: task));
            showsnackbar('${task.title} dismissed', context);
          },
          child: GestureDetector(
              onDoubleTap: () async {
                await PushNotification.createNotification();
              },
              onTap: () {
                addTask(
                  context,
                  TaskEntity(
                    title: task.title,
                    description: task.description,
                    isDone: task.isDone!,
                    taskId: task.taskId,
                    category: task.category,
                  ),
                  filteredCategory,
                );
              },
              child: ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                      decoration: task.isDone!
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
                subtitle: Text(task.description),
                trailing: Checkbox(
                  onChanged: (value) {
                    context.read<TasksBloc>().add(ToggleCheckBox(task: task));
                  },
                  value: task.isDone,
                ),
              )),
        );
      },
    ));
  }
}
