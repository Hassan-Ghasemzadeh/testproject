// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:equatable/equatable.dart';

import '../../data/models/task.dart';

class TaskActiveAndCompleteState extends Equatable {
  final int activeTask;

  final int completedTask;
  const TaskActiveAndCompleteState({
    required this.activeTask,
    required this.completedTask,
  });

  @override
  List<Object?> get props => [activeTask, completedTask];
}

TaskActiveAndCompleteState getTaskState(List<Task> tasks) {
  var size = tasks.length;
  final List<Task> completed =
      tasks.where((element) => element.isDone!).toList();

  final int completedTaskCount = completed.length;

  return TaskActiveAndCompleteState(
    activeTask: size - completedTaskCount,
    completedTask: completedTaskCount,
  );
}
