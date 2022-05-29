part of 'tasks_bloc.dart';

// ignore: must_be_immutable
class TasksState extends Equatable {
  final List<Task> tasks;
  final List<Task> filteredTaskList;

  final TaskActiveAndCompleteState state;
  final List<Category> categorys;
  final String currentCategory;
  final String currentFilter;
  const TasksState({
    this.tasks = const <Task>[],
    this.filteredTaskList = const <Task>[],
    this.state = const TaskActiveAndCompleteState(
        activeTaskPercent: 0, completedTaskPercent: 0),
    this.categorys = const <Category>[],
    this.currentCategory = 'All',
    this.currentFilter = 'All',
  });

  @override
  List<Object> get props => [
        ...tasks,
        ...filteredTaskList,
        state,
        categorys,
        currentCategory,
        currentFilter,
      ];
}
