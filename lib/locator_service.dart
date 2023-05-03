import 'package:get_it/get_it.dart';

import 'bloc/task_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Cubit
  sl.registerLazySingleton(() => TaskCubit(tasks: sl()));
}