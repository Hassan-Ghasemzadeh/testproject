// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  final bool needUpdate;
  const TasksEvent(this.needUpdate);

  @override
  List<Object> get props => [needUpdate];
}

class AddTask extends TasksEvent {
  final Task task;
  const AddTask({
    required this.task,
  }) : super(true);

  @override
  List<Object> get props => [task];
}

class ToggleCheckBox extends TasksEvent {
  final Task task;
  const ToggleCheckBox({
    required this.task,
  }) : super(true);

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TasksEvent {
  final Task task;
  const DeleteTask({
    required this.task,
  }) : super(true);

  @override
  List<Object> get props => [task];
}

class TaskActiveAndCompleteStatus extends TasksEvent {
  const TaskActiveAndCompleteStatus() : super(false);

  @override
  List<Object> get props => [];
}

class InsertCategoryEvent extends TasksEvent {
  final Category category;
  const InsertCategoryEvent(this.category) : super(false);

  @override
  List<Object> get props => [category];
}

class FilterTasksItem extends TasksEvent {
  final String filter;
  const FilterTasksItem(this.filter) : super(false);

  @override
  List<Object> get props => [filter];
}
