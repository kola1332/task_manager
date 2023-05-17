import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/screens/home/home.dart';
import 'bloc/task_cubit.dart';
import 'locator_service.dart' as di;
import 'locator_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return BlocProvider<TaskCubit>(
      create: (context) => sl<TaskCubit>()..getTasks(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flicker',
        home: HomePage(),
      ),
    );
  }
}
