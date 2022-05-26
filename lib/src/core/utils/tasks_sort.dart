import 'package:testproject/src/data/models/task.dart';

enum TaskSort {
  nameatoz,
  nameztoa,
}

void sortTask(TaskSort sort, List<Task> tasks) {
  switch (sort) {
    case TaskSort.nameatoz:
      tasks.sort(((a, b) {
        return a.title.toLowerCase().compareTo(b.title.toLowerCase());
      }));
      break;
    case TaskSort.nameztoa:
      tasks.sort(((a, b) {
        return -a.title.toLowerCase().compareTo(b.title.toLowerCase());
      }));
      break;
  }
}
