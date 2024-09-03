import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:tuduu/data/remote/firestore_service.dart';
import 'package:tuduu/repository/tasks/tasks_repository_protocol.dart';
import 'package:tuduu/data/model/task.dart' as t;

class TasksRepository implements TasksRepositoryProtocol {
  final FirestoreService firestoreService;

  TasksRepository({required this.firestoreService});

  @override
  Future<Either<Exception, List<t.Task>>> readTaskCollection(String userId) async {
    try {
      QuerySnapshot qs = await firestoreService.getTasksReference(userId).get();
      List<t.Task> tasks = qs.docs.map((doc) {
        return t.Task.fromMap(doc.data() as Map<String, dynamic>, doc.id); 
      }).toList();

      return Right(tasks);
    } catch (e) {
      return Left(Exception('failed to load tasks: $e'));
    }
  }
}