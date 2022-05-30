import 'package:flutter/material.dart';
import 'package:testproject/src/core/utils/tasks_sort.dart';
import 'package:testproject/src/data/models/task.dart';
import '../../core/utils/bottom_sheet.dart';
import '../../data/models/task_category.dart';
import '../blocs/bloc/tasks_bloc.dart';
import '../blocs/blocs_export.dart';
import '../widgets/tasks_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isAscending = true;
  void handleClick(String value) {
    switch (value) {
      case 'Manage Category':
        break;
    }
  }

  List<String> filterTaskState = ['Active', 'Completed', 'All'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasks = state.tasks;
        List<Task> filteredTask = state.filteredTaskList;
        List<Category> categorys = state.categorys;
        final currentCategory = state.currentCategory;

        final currentFilter = state.currentFilter;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Todo App"),
            actions: [
              IconButton(
                onPressed: () => addTask(context, null, categorys),
                icon: const Icon(
                  Icons.add,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isAscending = !isAscending;
                  });
                  isAscending
                      ? sortTask(TaskSort.nameatoz, tasks)
                      : sortTask(TaskSort.nameztoa, tasks);
                },
                child: Text(
                  isAscending ? 'Ascending' : 'Descending',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) => handleClick(value),
                itemBuilder: (BuildContext context) {
                  return {'Manage Category'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice,
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //category list
              SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                    itemCount: categorys.length,
                    itemBuilder: (context, index) {
                      final category = categorys[index];

                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                        child: GestureDetector(
                            onTap: () {
                              context.read<TasksBloc>().add(
                                    FilterTasksItem(
                                      tasks: state.tasks,
                                      currentFilter: state.currentFilter,
                                      currentCategory: category.name,
                                      filteredTasks: state.filteredTaskList,
                                    ),
                                  );
                            },
                            child: SizedBox(
                              width: 90,
                              height: 40,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                  color: currentCategory == category.name
                                      ? Colors.blue
                                      : const Color.fromARGB(
                                          255, 233, 246, 255),
                                  borderRadius: currentCategory == category.name
                                      ? BorderRadius.circular(10)
                                      : BorderRadius.circular(25),
                                  // elevation: 0,
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(10.0),
                                  // ),
                                ),
                                child: Center(
                                  child: Text(
                                    category.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 13.0),
                                  ),
                                ),
                              ),
                            )),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                  )),
              //all , active, completed list filter.
              SizedBox(
                  height: 50.0,
                  child: ListView.builder(
                    itemCount: filterTaskState.length,
                    itemBuilder: (context, index) {
                      final filterItem = filterTaskState[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 10.0, top: 10.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: (() {
                                context.read<TasksBloc>().add(
                                      FilterTasksItem(
                                          tasks: state.filteredTaskList,
                                          currentFilter: filterItem,
                                          currentCategory:
                                              state.currentCategory,
                                          filteredTasks:
                                              state.filteredTaskList),
                                    );
                              }),
                              child: Wrap(
                                children: [
                                  Text(
                                    filterItem,
                                    style: TextStyle(
                                        color: currentFilter == filterItem
                                            ? const Color.fromARGB(255, 0, 0, 0)
                                            : const Color.fromARGB(
                                                255, 158, 158, 158)),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                  )),
              TasksList(
                categorys: categorys,
                tasks: tasks,
                filteredTaskList: filteredTask,
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<TasksBloc>()
                      .add(const TaskActiveAndCompleteStatus());
                },
                child: Text(
                  'Active: ${state.state.activeTaskPercent.toStringAsFixed(2)}%'
                  ' complete: ${state.state.completedTaskPercent.toStringAsFixed(2)}%',
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => addTask(context, null, categorys),
            tooltip: 'add task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
