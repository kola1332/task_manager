import '../models/task.dart';

abstract class TaskState {}

class TaskStateEmpty extends TaskState {}

class TaskStateLoading extends TaskState {}

class TaskStateLoaded extends TaskState {
  final List<Task> tasks;
  // List<Map> desks = [];
  // Map newDesk = {};
  Desk? newDesk;

  TaskStateLoaded(this.tasks);
}

class TaskStateError extends TaskState {}
