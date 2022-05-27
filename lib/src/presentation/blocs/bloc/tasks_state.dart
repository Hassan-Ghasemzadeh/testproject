// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  List<Task> tasks;
  TaskActiveAndCompleteState state;
  TasksState([
    this.tasks = const <Task>[],
    this.state =
        const TaskActiveAndCompleteState(activeTask: 0, completedTask: 0),
  ]);

  @override
  List<Object> get props => [tasks];
}
