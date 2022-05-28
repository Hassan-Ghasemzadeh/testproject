import 'package:flutter/material.dart';

import '../../data/models/task_category.dart';
import '../../domain/entities/task_entity.dart';
import '../../presentation/widgets/add_task_widget.dart';

void addTask(
    BuildContext context, TaskEntity? entity, List<Category> categorys) {
  showModalBottomSheet(
    context: context,
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: AddView(
          entity: entity,
          categorys: categorys,
        ),
      ),
    ),
  );
}
