import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testproject/src/core/utils/shared_pref_util.dart';
import 'package:testproject/src/data/datasources/hive_datasource.dart';
import 'package:testproject/src/data/datasources/task_data_source.dart';
import 'package:testproject/src/data/models/task.dart';
import 'package:testproject/src/domain/repositories/task_repo_impl.dart';

import 'data/datasources/sqflite_datasource.dart';

final GetIt injector = GetIt.instance;

Future<void> setUp() async {
  final path = await getApplicationSupportDirectory();
  Hive
    ..init(path.path)
    ..registerAdapter(TaskAdapter());

  final box = await Hive.openBox<Task>('task');
  injector.registerSingleton<Box<Task>>(box);
  injector.registerSingleton<SharedPrefUtil>(SharedPrefUtil());
  injector.registerSingleton<TaskRepositoryImpl>(
    TaskRepositoryImpl(
      TaskDataSource(),
      injector(),
      HiveDataSource(),
      SqfliteDataSource(),
    ),
  );
}
