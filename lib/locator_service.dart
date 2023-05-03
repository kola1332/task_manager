import 'package:get_it/get_it.dart';
import 'package:task_manager/models/task.dart';

import 'bloc/task_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
//   // Models
//   sl.registerLazySingleton(() => Task());
  // Cubit
  sl.registerFactory(() => TaskCubit(tasks: sl()));
}