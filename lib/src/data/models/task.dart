// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  final String title;
  final String description;
  bool? isDone;
  final String id;
  final String category;
  final String dateCreated;

  Task({
    required this.title,
    required this.description,
    this.isDone,
    required this.id,
    required this.category,
    required this.dateCreated,
  }) {
    isDone = isDone ?? false;
  }

  Task copyWith({
    String? title,
    String? description,
    bool? isDone,
    String? id,
    String? category,
    String? dateCreated,
  }) {
    return Task(
        title: title ?? this.title,
        description: description ?? this.description,
        isDone: isDone ?? this.isDone,
        id: id ?? this.id,
        category: category ?? this.category,
        dateCreated: dateCreated ?? this.dateCreated);
  }

  @override
  List<Object?> get props => [title, description, isDone, id, category];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'isDone': isDone,
      'id': id,
      'category': category,
      'dateCreated': dateCreated,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
      id: map['id'] as String,
      category: map['category'] as String,
      dateCreated: map['dateCreated'] as String,
    );
  }
}
