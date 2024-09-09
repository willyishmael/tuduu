import 'package:equatable/equatable.dart';
import 'package:tuduu/data/model/task.dart';
import 'package:tuduu/failure/failure.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

final class TaskInitialState extends TaskState {}

final class TaskLoadingState extends TaskState {}

final class TaskLoadedState extends TaskState {
  final List<Task> tasks;
  const TaskLoadedState({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

final class TaskErrorState extends TaskState {
  final Failure failure;
  const TaskErrorState({required this.failure});

  @override
  List<Object?> get props => [failure];
}
