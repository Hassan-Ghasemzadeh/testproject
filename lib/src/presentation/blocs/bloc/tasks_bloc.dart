import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/data/models/task_category.dart';
import 'package:testproject/src/domain/repositories/task_repo_impl.dart';
import 'package:testproject/src/domain/usecases/add_task_usecase.dart';
import 'package:testproject/src/domain/usecases/delete_usecase.dart';
import 'package:testproject/src/domain/usecases/get_active_and_complete_task_status.dart';
import 'package:testproject/src/domain/usecases/insert_category.dart';
import 'package:testproject/src/domain/usecases/toggle_checkbox_usecase.dart';
import 'package:uuid/uuid.dart';
import '../../../injector.dart';
part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepositoryImpl repo = injector<TaskRepositoryImpl>();
  AddTaskUseCase get _addTaskUseCase => AddTaskUseCase(repo);
  ToggleCheckBoxUseCase get _toggleTaskUsecase =>
      ToggleCheckBoxUseCase(repo: repo);
  GetStatusUseCase get _getStatusOfTasksUsecase => GetStatusUseCase(repo);
  DeleteTaskUseCase get _deleteTaskUsecase => DeleteTaskUseCase(repo);
  InsertCategoryUsecase get _insertCtg => InsertCategoryUsecase(repo: repo);
  List<Category> categorys = <Category>[
    Category(
      name: 'All',
      id: const Uuid().v4().toString(),
    ),
    Category(
      name: 'Birthday',
      id: const Uuid().v4().toString(),
    ),
    Category(
      name: 'Personal',
      id: const Uuid().v4().toString(),
    ),
    Category(
      name: 'WishList',
      id: const Uuid().v4().toString(),
    )
  ];

  List<Task> filteredTaskList = <Task>[];
  TasksBloc() : super(const TasksState()) {
    on<TasksEvent>((event, emit) {
      if (event.needUpdate) {
        add(const TaskActiveAndCompleteStatus());
      }
    });
    on<AddTask>((event, emit) async {
      final state = this.state;
      final tasks = await _addTaskUseCase.invoke(state.tasks, event.task);
      emit(
        TasksState(
          tasks: tasks,
          categorys: categorys,
        ),
      );
    });

    on<ToggleCheckBox>(((event, emit) async {
      final state = this.state;
      final tasks = await _toggleTaskUsecase.invoke(state.tasks, event.task);
      emit(TasksState(
        tasks: tasks,
        categorys: categorys,
      ));
    }));

    on<DeleteTask>((event, emit) async {
      final state = this.state;
      final tasks = await _deleteTaskUsecase.invoke(state.tasks, event.task);
      emit(
        TasksState(tasks: tasks, categorys: categorys),
      );
    });

    on<TaskActiveAndCompleteStatus>(
      ((event, emit) async {
        final state = this.state;
        final result = await _getStatusOfTasksUsecase.invoke(state.tasks);

        emit(TasksState(
            tasks: state.tasks, state: result, categorys: categorys));
      }),
    );

    on<InsertCategoryEvent>(((event, emit) async {
      final state = this.state;
      final result = await _insertCtg.invoke(categorys, event.category);

      categorys = result;
      emit(TasksState(
        categorys: categorys,
        tasks: state.tasks,
      ));
    }));

    emit(TasksState(categorys: categorys));
  }
}
