part of 'tasks_bloc.dart';

// ignore: must_be_immutable
class TasksState extends Equatable {
  final List<Task> filteredTaskList;
  final TaskActiveAndCompleteState state;
  final List<Category> categorys;
  final String currentCategory;
  final String currentFilter;
  final List<Task> taskByDate;
  final String currentDate;
  const TasksState({
    this.filteredTaskList = const <Task>[],
    this.state = const TaskActiveAndCompleteState(
        activeTaskPercent: 0, completedTaskPercent: 0),
    this.categorys = const <Category>[],
    this.currentCategory = 'All',
    this.currentFilter = 'All',
    this.taskByDate = const <Task>[],
    this.currentDate = '',
  });

  @override
  List<Object> get props => [
        ...filteredTaskList,
        state,
        categorys,
        currentCategory,
        currentFilter,
        ...taskByDate,
        currentDate,
      ];
}
