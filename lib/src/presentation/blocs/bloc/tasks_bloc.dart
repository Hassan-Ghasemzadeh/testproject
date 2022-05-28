import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/domain/repositories/task_repo_impl.dart';
import 'package:testproject/src/domain/usecases/add_task_usecase.dart';
import 'package:testproject/src/domain/usecases/delete_usecase.dart';
import 'package:testproject/src/domain/usecases/get_active_and_complete_task_status.dart';
import 'package:testproject/src/domain/usecases/toggle_checkbox_usecase.dart';

import '../../../injector.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState()) {
    final TaskRepositoryImpl repo = injector<TaskRepositoryImpl>();
    AddTaskUseCase add = AddTaskUseCase(repo);
    ToggleCheckBoxUseCase toggle = ToggleCheckBoxUseCase(repo: repo);
    DeleteTaskUseCase delete = DeleteTaskUseCase(repo);
    GetStatusUseCase status = GetStatusUseCase(repo);
    on<AddTask>((event, emit) async {
      final state = this.state;
      final tasks = await add.invoke(state.tasks, event.task);

      emit(TasksState(tasks: tasks));
    });

    on<ToggleCheckBox>(((event, emit) async {
      final state = this.state;
      final result = await toggle.invoke(state.tasks, event.task);
      emit(TasksState(tasks: result));
    }));

    on<DeleteTask>((event, emit) async {
      final state = this.state;
      final result = await delete.invoke(state.tasks, event.task);
      emit(TasksState(tasks: result));
    });

    on<TaskActiveAndCompleteStatus>(((event, emit) async {
      try {
        final state = this.state;
        final result = await status.invoke(state.tasks);

        emit(TasksState(state: result));
      } catch (e) {
        e.toString();
      }
    }));
  }
}
