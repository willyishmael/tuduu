import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuduu/data/remote/firestore_service.dart';
import 'package:tuduu/pages/task/cubit/task_cubit.dart';
import 'package:tuduu/pages/task/cubit/task_state.dart';
import 'package:tuduu/pages/task/task_list_item.dart';
import 'package:tuduu/repository/tasks/tasks_repository.dart';
import 'dart:developer' as dev;

class TaskPage extends StatefulWidget {
  final TaskCubit taskCubit = TaskCubit(
    tasksRepository: TasksRepository(firestoreService: FirestoreService()),
  );

  TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  void initState() {
    super.initState();
    widget.taskCubit.loadTasks('userUnderTest1');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (context) => widget.taskCubit,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Group Title",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                if (state is TaskLoadingState) {
                  dev.log('@TaskLoadingState');
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TaskLoadedState) {
                  dev.log('@TaskLoadedState');
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return TaskListItem(task: task);
                    },
                  );
                } else if (state is TaskErrorState) {
                  dev.log('@TaskErrorState');
                  return Center(child: Text(state.failure.message));
                } else {
                  return const Center(child: Text('No tasks available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
