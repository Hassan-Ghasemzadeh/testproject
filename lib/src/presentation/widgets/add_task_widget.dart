// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/presentation/blocs/bloc/tasks_bloc.dart';

class AddView extends StatelessWidget {
  const AddView({
    Key? key,
    required this.titleController,
    required this.descriptionController,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return AddTaskView(
      titleController: titleController,
      descriptionController: descriptionController,
    );
  }
}

class AddTaskView extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  const AddTaskView({
    Key? key,
    required this.titleController,
    required this.descriptionController,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Add Task',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            autofocus: true,
            controller: widget.titleController,
            decoration: const InputDecoration(
                label: Text('title'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextField(
            controller: widget.descriptionController,
            decoration: const InputDecoration(
                label: Text('description'),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)))),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    var task = Task(
                        title: widget.titleController.text,
                        description: widget.descriptionController.text,
                        id: const Uuid().v4().toString());
                    context.read<TasksBloc>().add(AddTask(task: task));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Save'))
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.descriptionController.clear();
    widget.titleController.clear();
  }
}
