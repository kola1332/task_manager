import 'package:flutter/material.dart';

import '../core/db/database.dart';
import '../models/task.dart';

abstract class TaskLocalDataSource {
  Future<void> taskToSql(List<TaskModel> tasks);
  Future<List<TaskModel>> getSql();
  Future<void> deskToSql(Desk desk);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  final db = DBProvider.db;

  @override
  Future<void> taskToSql(List<TaskModel> tasks) async {
    var dbTask = await db.database;
    for (var taskItem in tasks) {
      await dbTask.insert('taskTable', {
        'iconData':
            taskItem.iconData != null ? taskItem.iconData?.codePoint : 0,
        'title': taskItem.title,
        'bgColor': taskItem.bgColor.toString(),
        'iconColor': taskItem.iconColor.toString(),
        'btnColor': taskItem.btnColor.toString(),
        'left': taskItem.left,
        'done': taskItem.done,
        'isLast': taskItem.isLast ? 1 : 0,
      });
      if (taskItem.desc != null) {
        for (var deskItem in taskItem.desc!) {
          await dbTask.insert('deskTable', {
            'newTime': deskItem.newTime!.toString(), // ? help
            'title': deskItem.title,
            'slot': deskItem.slot,
            'bgColor': deskItem.bgColor.toString(),
            'tlColor': deskItem.tlColor.toString(),
            'chap': deskItem.chap,
          });
        }
      }
    }
  }

  @override
  Future<List<TaskModel>> getSql() async {
    var dbTask = await db.database;
    List<TaskModel> taskList = [];
    // List<Desk> deskList = [];
    // List<Desk> newDeskList = [];
    Map<String, List<Desk>> deskMap = {};
    String? title;
    final List<Map<String, dynamic>> listTask = await dbTask.query('taskTable');
    final List<Map<String, dynamic>> listDesk = await dbTask.query('deskTable');
    for (var deskItem in listDesk) {
      var time = deskItem['newTime'] as String;
      time = time.split("(")[1].split(")")[0];
      // if (deskItem['title'] != 'null'
      //     && deskMap.entries.contains(deskItem['title'])
      //     ) {
      title ??= deskItem['chap'];
      // if (title != deskItem['chap']) {
      //   deskList = [];
      // }
      // deskList.add(Desk(
      //   newTime: TimeOfDay(
      //       hour: int.parse(time.split(":")[0]),
      //       minute: int.parse(time.split(":")[1])),
      //   title: deskItem['title'],
      //   slot: deskItem['slot'],
      //   bgColor: hexToColor(deskItem['bgColor']),
      //   tlColor: hexToColor(deskItem['tlColor']),
      //   chap: deskItem['chap'],
      // ));
      // if (deskMap.containsKey(deskItem['chap'])) {
      // for (int i = 0; i < deskList.length;i++) {
      // deskMap[deskItem['chap']]!.addAll(deskList);
      // }
      // } else {
      // deskMap.addAll({deskItem['chap']: deskList});
      deskMap[deskItem['chap']] ??= [];
      deskMap[deskItem['chap']]!.add(Desk(
        newTime: TimeOfDay(
            hour: int.parse(time.split(":")[0]),
            minute: int.parse(time.split(":")[1])),
        title: deskItem['title'],
        slot: deskItem['slot'],
        bgColor: hexToColor(deskItem['bgColor']),
        tlColor: hexToColor(deskItem['tlColor']),
        chap: deskItem['chap'],
      ));

      // }
      // }
      print(deskItem['chap']); // ? del
    }
    for (var taskItem in listTask) {
      // for (int i = 0; i < listTask.length; i++) {
      taskList.add(TaskModel(
        desc: deskMap[taskItem['title']],
        iconData: taskItem['iconData'] != 0
            ? IconData(taskItem['iconData'], fontFamily: 'MaterialIcons')
            : null,
        title: taskItem['title'],
        bgColor: hexToColor(taskItem['bgColor']),
        iconColor: hexToColor(taskItem['iconColor']),
        btnColor: hexToColor(taskItem['btnColor']),
        left: taskItem['left'],
        done: taskItem['done'],
        isLast: taskItem['isLast'] == 1 ? true : false,
      ));
    }
    return taskList;
  }

  @override
  Future<void> deskToSql(Desk desk) async {
    var dbTask = await db.database;
    await dbTask.insert('deskTable', {
      'newTime': desk.newTime!.toString(),
      'title': desk.title,
      'slot': desk.slot,
      'bgColor': desk.bgColor.toString(),
      'tlColor': desk.tlColor.toString(),
      'chap': desk.chap,
    });
  }

  Color? hexToColor(String code) {
    if (code == 'null') {
      return null;
    }
    String valueString = code.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    return Color(value);
  }
}
