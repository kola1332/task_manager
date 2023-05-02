import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_manager/screens/home/home.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    //   systemNavigationBarColor: Colors.white,
    //   systemNavigationBarDividerColor: Colors.white,
    // ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flicker',
      home: HomePage(),
    );
  }
}
