import '../core/error/failure.dart';
import '../models/task.dart';
import 'data_source.dart';
import 'package:dartz/dartz.dart';

class Repository {
  // List<Task> tasks = [];
  final TaskLocalDataSource taskLocalDataSource;

  Repository(this.taskLocalDataSource);

  Future<Either<Failure, List<TaskModel>>> getTasks() async {
    List<TaskModel> taskList;
    try {
      taskList = await taskLocalDataSource.getSql();
      if (taskList == [] || taskList.isEmpty) {
        throw Exception();
      } else {
        return Right(taskList);
      }
    } catch (e) {
      // List<TaskModel> taskList = await remoteDataSource.getTask();
      taskList = TaskModel.generateTasks();
      await taskLocalDataSource.taskToSql(taskList);
      taskList = await taskLocalDataSource.getSql();
      return Right(taskList);
    }
  }

  update(List<TaskModel> tasks) async {
    await taskLocalDataSource.taskToSql(tasks);
  }
}
