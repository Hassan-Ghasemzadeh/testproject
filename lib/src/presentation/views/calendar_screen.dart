import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:testproject/src/presentation/widgets/calendar_widget.dart';

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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 400.0,
              child: CalendarWidget(
                onDateSelected: (currentDate) {
                  final current =
                      DateFormat('yyyy-MM-dd HH:mm:ss').parse(currentDate);

                  context.read<TasksBloc>().add(
                        GetTaskOnSpecificDate(
                          date: current.toString(),
                        ),
                      );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: state.taskByDate.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.taskByDate[index].title),
                      subtitle: Text(state.taskByDate[index].description),
                    );
                  }),
            ),
          ],
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
