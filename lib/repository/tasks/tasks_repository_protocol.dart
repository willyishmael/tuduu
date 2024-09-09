import 'package:dartz/dartz.dart';
import 'package:tuduu/data/model/task.dart' as t;
import 'package:tuduu/failure/failure.dart';

abstract class TasksRepositoryProtocol {
  Future<Either<Failure, List<t.Task>>> readTaskCollection(String userId);
}