import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/bloc/task_state.dart';

import '../models/task.dart';

class TaskCubit extends Cubit<TaskState> {
  List<Task> tasks;

  TaskCubit({required this.tasks}) : super(TaskStateEmpty());

  void getTasks() {
    // if (state is TaskStateLoading) return;
    // final currentState = state;

    tasks = Task.generateTasks();
  }
}
