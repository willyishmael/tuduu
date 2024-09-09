import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuduu/failure/failure.dart';
import 'package:tuduu/pages/task/cubit/task_state.dart';
import 'package:tuduu/repository/tasks/tasks_repository_protocol.dart';

class TaskCubit extends Cubit<TaskState> {
  final TasksRepositoryProtocol tasksRepository;

  TaskCubit({required this.tasksRepository}) : super(TaskInitialState());

  Future<void> loadTasks(String userId) async {
    emit(TaskLoadingState());
    try {
      final result = await tasksRepository.readTaskCollection(userId);
      result.fold(
        (failure) => emit(TaskErrorState(failure: failure)),
        (tasks) => emit(TaskLoadedState(tasks: tasks)),
      );
    } catch (error) {
      final failure = CubitFailure(
        message: 'Task Cubit: Failed to load Tasks',
        stackTrace: error.toString(),
      );
      emit(TaskErrorState(failure: failure));
    }
  }
}
