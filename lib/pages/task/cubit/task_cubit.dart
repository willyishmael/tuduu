import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuduu/model/task.dart';
import 'package:tuduu/pages/task/cubit/task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(super.initialState);

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
