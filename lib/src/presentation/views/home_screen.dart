import 'package:flutter/material.dart';
import 'package:testproject/src/core/utils/tasks_sort.dart';
import 'package:testproject/src/data/models/task.dart';
import '../blocs/bloc/tasks_bloc.dart';
import '../blocs/blocs_export.dart';
import '../widgets/add_task_widget.dart';
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
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isAscending = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    titleController.dispose();
    descriptionController.dispose();
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddView(
              titleController: titleController,
              descriptionController: descriptionController),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> tasks = state.tasks;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Todo App"),
            actions: [
              IconButton(
                onPressed: () => _addTask(context),
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
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Chip(label: Text("Tasks")),
              ),
              TasksList(tasks: tasks),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<TasksBloc>()
                      .add(TaskActiveAndCompleteStatus(tasks: tasks));
                },
                child: Text(
                  'Active:${state.state.activeTask} complete:${state.state.completedTask}',
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'add task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
