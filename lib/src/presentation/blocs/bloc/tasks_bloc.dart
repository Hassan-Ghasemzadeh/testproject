// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:testproject/src/core/utils/task_state.dart';
import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/data/models/task_category.dart';
import 'package:testproject/src/domain/repositories/task_repo_impl.dart';
import 'package:testproject/src/domain/usecases/add_task_usecase.dart';
import 'package:testproject/src/domain/usecases/delete_usecase.dart';
import 'package:testproject/src/domain/usecases/filter_task_usecase.dart';
import 'package:testproject/src/domain/usecases/get_active_and_complete_task_status.dart';
import 'package:testproject/src/domain/usecases/get_task_on_specific_date.dart';
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
  FilterTaskUseCase get filterTaskUseCase => FilterTaskUseCase(repo);
  GetTaskDateCreatedUseCase get getTaskByDate =>
      GetTaskDateCreatedUseCase(repo);
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
  List<Task> taskslist = <Task>[];
  TaskActiveAndCompleteState status = const TaskActiveAndCompleteState(
      activeTaskPercent: 0, completedTaskPercent: 0);

  List<Task> tasksByDate = <Task>[];
  String currentCategoryItem = 'All';
  String currentFilterItem = 'All';

  TasksBloc() : super(const TasksState()) {
    on<TasksEvent>((event, emit) {
      if (event.needUpdate) {
        add(const TaskActiveAndCompleteStatus());
      }
    });
    on<AddTask>((event, emit) async {
      final tasks = await _addTaskUseCase.invoke(event.task);
      debugPrint(tasks.map((e) => e.toMap()).toString());
      taskslist = tasks;
      emit(
        TasksState(
          tasks: taskslist,
          categorys: categorys,
          currentCategory: currentCategoryItem,
          currentFilter: currentFilterItem,
          filteredTaskList: filteredTaskList,
          state: status,
        ),
      );
      add(
        FilterTasksItem(
          tasks: taskslist,
          currentFilter: currentFilterItem,
          currentCategory: currentCategoryItem,
          filteredTasks: filteredTaskList,
        ),
      );
    });

    on<ToggleCheckBox>(
      ((event, emit) async {
        final tasks = await _toggleTaskUsecase.invoke(event.task);
        taskslist = tasks;

        emit(TasksState(
          tasks: taskslist,
          categorys: categorys,
          currentCategory: currentCategoryItem,
          currentFilter: currentFilterItem,
          filteredTaskList: filteredTaskList,
          state: status,
        ));
        add(
          FilterTasksItem(
            tasks: taskslist,
            currentFilter: currentFilterItem,
            currentCategory: currentCategoryItem,
            filteredTasks: filteredTaskList,
          ),
        );
      }),
    );

    on<DeleteTask>((event, emit) async {
      final tasks = await _deleteTaskUsecase.invoke(event.task);
      taskslist = tasks;

      emit(
        TasksState(
          tasks: taskslist,
          categorys: categorys,
          filteredTaskList: filteredTaskList,
          currentCategory: currentCategoryItem,
          currentFilter: currentFilterItem,
          state: status,
        ),
      );
      add(
        FilterTasksItem(
          tasks: taskslist,
          currentFilter: currentFilterItem,
          currentCategory: currentCategoryItem,
          filteredTasks: filteredTaskList,
        ),
      );
    });

    on<TaskActiveAndCompleteStatus>(
      ((event, emit) async {
        final result = await _getStatusOfTasksUsecase.invoke();

        status = result;

        emit(
          TasksState(
            tasks: taskslist,
            state: status,
            categorys: categorys,
            currentCategory: currentCategoryItem,
            currentFilter: currentFilterItem,
            filteredTaskList: filteredTaskList,
          ),
        );
      }),
    );

    on<InsertCategoryEvent>(
      ((event, emit) async {
        final result = await _insertCtg.invoke(categorys, event.category);

        categorys = result;
        emit(
          TasksState(
            categorys: categorys,
            tasks: taskslist,
            currentCategory: currentCategoryItem,
            currentFilter: currentFilterItem,
            state: status,
            filteredTaskList: filteredTaskList,
          ),
        );
      }),
    );

    on<FilterTasksItem>(
      ((event, emit) async {
        final result = await filterTaskUseCase.invoke(
          event.currentFilter,
          event.currentCategory,
        );
        filteredTaskList = result;
        currentCategoryItem = event.currentCategory;
        currentFilterItem = event.currentFilter;
        final filteredState = TasksState(
          categorys: categorys,
          tasks: filteredTaskList,
          filteredTaskList: filteredTaskList,
          currentCategory: event.currentCategory,
          currentFilter: event.currentFilter,
          state: status,
        );

        emit(
          filteredState,
        );
      }),
    );

    on<GetTaskOnSpecificDate>((event, emit) async {
      final tasks = await getTaskByDate.invoke(event.date);
      tasksByDate = tasks;

      final tasksByDateCreated = TasksState(
          categorys: categorys,
          tasks: filteredTaskList,
          filteredTaskList: filteredTaskList,
          currentCategory: currentCategoryItem,
          currentFilter: currentFilterItem,
          state: status,
          taskByDate: tasksByDate,
          currentDate: event.date);
      emit(tasksByDateCreated);
    });

    emit(
      TasksState(categorys: categorys),
    );
  }
}
