// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  bool? isDone;
  @HiveField(3)
  final String taskId;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final String dateCreated;

  int? id;

  Task({
    required this.title,
    required this.description,
    this.isDone,
    required this.taskId,
    required this.category,
    required this.dateCreated,
    this.id,
  }) {
    isDone = isDone ?? false;
  }

  Task copyWith({
    String? title,
    String? description,
    bool? isDone,
    String? taskId,
    String? category,
    String? dateCreated,
    int? id,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      taskId: taskId ?? this.taskId,
      category: category ?? this.category,
      dateCreated: dateCreated ?? this.dateCreated,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [title, description, isDone, taskId, category];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'isDone': isDone,
      'taskId': taskId,
      'category': category,
      'dateCreated': dateCreated,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      taskId: map['taskId'] as String,
      category: map['category'] as String,
      dateCreated: map['dateCreated'] as String,
      id: map['id'] as int,
    );
  }

  factory Task.fromMapSql(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] == 1,
      taskId: map['taskId'] as String,
      category: map['category'] as String,
      dateCreated: map['dateCreated'] as String,
      id: map['id'] as int,
    );
  }
}
