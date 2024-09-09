import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tuduu/data/remote/firestore_service.dart';
import 'package:tuduu/failure/failure.dart';
import 'package:tuduu/repository/tasks/tasks_repository_protocol.dart';
import 'package:tuduu/data/model/task.dart' as t;

class TasksRepository implements TasksRepositoryProtocol {
  final FirestoreService firestoreService;

  TasksRepository({required this.firestoreService});

  @override
  Future<Either<Failure, List<t.Task>>> readTaskCollection(
      String userId) async {
    try {
      QuerySnapshot qs = await firestoreService.getTasksReference(userId).get();
      List<t.Task> tasks = qs.docs.map((doc) {
        return t.Task.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      if (tasks.isEmpty) {
        const message = 'Tasks Repository: Empty Response';
        return const Left(EmptyResponseFailure(message: message));
      } else {
        return Right(tasks);
      }
    } catch (error) {
      final failure = ServerFailure(
        message: 'Tasks Repository: Failed to load Tasks',
        stackTrace: error.toString(),
      );

      return Left(failure);
    }
  }
}
