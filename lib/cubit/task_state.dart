import '../models/task.dart';

abstract class TaskState {}

class TaskStateEmpty extends TaskState {}

class TaskStateLoading extends TaskState {}

class TaskStateLoaded extends TaskState {
  final List<TaskModel> tasks;
  Desk? newDesk;

  TaskStateLoaded(this.tasks);
}

class TaskStateUpdate extends TaskState {
  final List<TaskModel> tasks;

  TaskStateUpdate(this.tasks);
}

class TaskStateError extends TaskState {
  final String message;

  TaskStateError(this.message);
}
