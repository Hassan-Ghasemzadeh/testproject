// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/src/core/utils/text_field_util.dart';
import 'package:testproject/src/data/models/task_category.dart';
import 'package:testproject/src/domain/entities/task_entity.dart';
import 'package:uuid/uuid.dart';

import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/presentation/blocs/bloc/tasks_bloc.dart';

class AddView extends StatelessWidget {
  const AddView({
    Key? key,
    required this.entity,
    required this.categorys,
  }) : super(key: key);

  final TaskEntity? entity;
  final List<Category> categorys;
  @override
  Widget build(BuildContext context) {
    inspect(entity);
    return AddTaskView(
      entity: entity ??
          TaskEntity(
            title: '',
            description: '',
            isDone: false,
            id: const Uuid().v4().toString(),
            category: 'Birthday',
          ),
      categorys: categorys,
    );
  }
}

class AddTaskView extends StatefulWidget {
  final TaskEntity entity;

  final List<Category> categorys;
  const AddTaskView({Key? key, required this.entity, required this.categorys})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  late Map<String, InputFieldPrams> controllers;
  String dropdownValue = 'Birthday';
  @override
  void initState() {
    super.initState();
    controllers = {
      'title': InputFieldPrams(
        TextEditingController(text: widget.entity.title)
          ..addListener(() {
            widget.entity.title = controllers['title']!.controller.text;
          }),
        TextInputType.name,
      ),
      'description': InputFieldPrams(
        TextEditingController(text: widget.entity.description)
          ..addListener(() {
            widget.entity.description =
                controllers['description']!.controller.text;
          }),
        TextInputType.name,
      ),
    };
  }

  @override
  void dispose() {
    super.dispose();
    for (final conroller in controllers.values) {
      conroller.controller.dispose();
    }
  }

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
          ...controllers.entries.map(
            (e) {
              return Container(
                padding: const EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: e.value.controller,
                  keyboardType: e.value.type,
                  decoration: InputDecoration(
                    hintText: 'Input your ${e.key} here',
                    labelText: e.key,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    ),
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: DropdownButton<String>(
                    value: widget.entity.category,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        widget.entity.category = newValue!;
                      });
                    },
                    items: widget.categorys
                        .map<DropdownMenuItem<String>>((Category value) {
                      return DropdownMenuItem<String>(
                        value: value.name,
                        child: Text(value.name),
                      );
                    }).toList(),
                  )),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  var task = Task(
                    title: controllers['title']!.controller.text,
                    description: controllers['description']!.controller.text,
                    id: widget.entity.id,
                    category: widget.entity.category,
                  );

                  context.read<TasksBloc>().add(AddTask(task: task));

                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
