import 'package:get_it/get_it.dart';
import 'package:task_manager/data/repo.dart';

import 'bloc/task_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Repository
  sl.registerLazySingleton(() => Repository());
  // Cubit
  sl.registerFactory(() => TaskCubit(repository: sl()));
}