import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuduu/pages/task/cubit/task_state.dart';
import 'package:tuduu/repository/tasks/tasks_repository_protocol.dart';

class TaskCubit extends Cubit<TaskState> {
  final TasksRepositoryProtocol tasksRepository;

  TaskCubit({required this.tasksRepository}) : super(TaskInitialState());

  Future<void> loadTasks(String userId) async {
    emit(TaskLoadingState());

    final result = await tasksRepository.readTaskCollection(userId);

    result.fold(
      (error) => emit(TaskErrorState(errorMessage: error.toString())),
      (tasks) => emit(TaskLoadedState(tasks: tasks)),
    );
  }
}
