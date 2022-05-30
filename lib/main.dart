import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/src/injector.dart';

import 'src/presentation/blocs/bloc/tasks_bloc.dart';
import 'src/presentation/widgets/bottom_navigator.dart';

void main() {
  setUp();
  BlocOverrides.runZoned(() => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Todo App",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyAppBottomNavigator(),
      ),
    );
  }
}
