import 'package:dartz/dartz.dart';
import 'package:tuduu/data/model/task.dart' as t;

abstract class TasksRepositoryProtocol {
  Future<Either<Exception, List<t.Task>>> readTaskCollection(String userId);
}