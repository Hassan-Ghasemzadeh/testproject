part of 'tasks_bloc.dart';

// ignore: must_be_immutable
class TasksState extends Equatable {
  final List<Task> tasks;
  final TaskActiveAndCompleteState state;
  final List<Category> categorys;
  final List<Task> filteredTasks;

  const TasksState(
      {this.tasks = const <Task>[],
      this.state = const TaskActiveAndCompleteState(
          activeTaskPercent: 0, completedTaskPercent: 0),
      this.categorys = const <Category>[],
      this.filteredTasks = const <Task>[]});

  @override
  List<Object> get props => [tasks, state];
}
