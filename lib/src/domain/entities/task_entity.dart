// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  late String title;

  late String description;

  final bool isDone;

  final String id;

  String category;

  TaskEntity(
      {required this.title,
      required this.description,
      required this.isDone,
      required this.id,
      required this.category});

  @override
  List<Object?> get props => [title, description, isDone, category];
}
