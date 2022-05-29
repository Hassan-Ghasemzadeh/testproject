import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/bottom_sheet.dart';
import '../blocs/bloc/tasks_bloc.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CalendarView();
  }
}

class CalendarView extends StatefulWidget {
  const CalendarView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar View'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addTask(context, null, state.categorys),
          tooltip: 'add task',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
