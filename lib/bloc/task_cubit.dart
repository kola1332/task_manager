import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/bloc/task_state.dart';
import 'package:task_manager/data/repo.dart';

import '../models/task.dart';

class TaskCubit extends Cubit<TaskState> {
  Repository repository = Repository();
  List<Task> tasks = Task.generateTasks();

  TaskCubit({required this.repository}) : super(TaskStateEmpty());

  void getTasks() {
    if (state is TaskStateLoading) return;
    // final currentState = state;

    emit(TaskStateLoaded(tasks));
  }
}
