import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuduu/data/model/task.dart';
import 'package:tuduu/pages/task/cubit/task_state.dart';
import 'package:tuduu/repository/tasks/tasks_repository_protocol.dart';

class TaskCubit extends Cubit<TaskState> {
  final TasksRepositoryProtocol tasksRepository;

  TaskCubit({required this.tasksRepository}) : super(TaskInitialState());

  void loadTasks() async {
    emit(TaskLoadingState());
    try {
      // Simulate loading tasks from a repository
      List<Task> tasks = []; // Fetch or generate your tasks
      emit(TaskLoadedState(tasks: tasks));
    } catch (e) {
      emit(const TaskErrorState(errorMessage: 'Failed to load tasks'));
    }
  }
}
