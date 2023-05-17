// ignore_for_file: constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/bloc/task_state.dart';
// import 'package:task_manager/data/data_source.dart';

import '../core/error/failure.dart';
import '../data/rep.dart';
import '../models/task.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class TaskCubit extends Cubit<TaskState> {
  Repository repository;

  TaskCubit({required this.repository}) : super(TaskStateEmpty());

  void getTasks() async {
    if (state is TaskStateLoading) return;
    // final currentState = state;
    List<TaskModel> taskList = [];
    emit(TaskStateLoading());
    final failureOrTask = await repository.getTasks();
    failureOrTask.fold(
      (error) => emit(TaskStateError(_mapFailureToMessage(error))),
      (tasks) => taskList = tasks,
    );
    if (taskList == []) {
      emit(TaskStateError(''));
    } else {
      emit(TaskStateLoaded(taskList));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
