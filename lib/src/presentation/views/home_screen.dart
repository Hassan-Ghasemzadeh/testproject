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
  String currentFilterItem = 'All';
  bool isAscending = true;
  String currentCategory = 'All';
  void handleClick(String value) {
    switch (value) {
      case 'Manage Category':
        break;
    }
  }

  List<String> filterTaskState = ['Active', 'Completed', 'All'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasks = state.tasks;
        List<Category> categorys = state.categorys;
        List<Category> filteredCategory =
            categorys.where((element) => element.name != 'All').toList();

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
                              setState(() {
                                currentCategory = category.name;
                              });
                            },
                            child: SizedBox(
                              width: 90,
                              height: 40,
                              child: Card(
                                color: currentCategory == category.name
                                    ? Colors.blue
                                    : const Color.fromARGB(255, 233, 246, 255),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
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
                                setState(() {
                                  currentFilterItem = filterItem;
                                });
                              }),
                              child: Wrap(
                                children: [
                                  Text(
                                    filterItem,
                                    style: filterItem == currentFilterItem
                                        ? const TextStyle(
                                            color: Colors.black, fontSize: 12.0)
                                        : const TextStyle(
                                            color: Color.fromARGB(
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
                filteredTasks: state.filteredTasks,
                categorys: categorys,
                tasks: tasks,
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
            onPressed: () => addTask(context, null, filteredCategory),
            tooltip: 'add task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
