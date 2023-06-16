import 'package:get_it/get_it.dart';
import 'package:task_manager/data/data_source.dart';
import 'package:task_manager/data/rep.dart';

import 'cubit/task_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // LocalDataSource
  sl.registerLazySingleton<TaskLocalDataSource>(() => TaskLocalDataSourceImpl());
  // Repository
  sl.registerLazySingleton(() => Repository(sl()));
  // Cubit
  sl.registerFactory(() => TaskCubit(repository: sl()));
}
