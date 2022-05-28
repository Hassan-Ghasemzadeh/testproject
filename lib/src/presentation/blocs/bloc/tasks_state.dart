part of 'tasks_bloc.dart';

// ignore: must_be_immutable
class TasksState extends Equatable {
  final List<Task> tasks;
  final TaskActiveAndCompleteState state;
  const TasksState({
    this.tasks = const <Task>[],
    this.state = const TaskActiveAndCompleteState(activeTask: 0, completedTask: 0),
  });

  @override
  List<Object> get props => [tasks, state];
}
