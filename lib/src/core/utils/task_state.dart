// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TaskActiveAndCompleteState extends Equatable {
  final double activeTaskPercent;

  final double completedTaskPercent;
  const TaskActiveAndCompleteState({
    required this.activeTaskPercent,
    required this.completedTaskPercent,
  });

  @override
  List<Object?> get props => [activeTaskPercent, completedTaskPercent];
}
