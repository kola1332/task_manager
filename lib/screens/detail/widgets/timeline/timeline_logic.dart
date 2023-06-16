// import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';

class TimelineEngine {
  List<Desk> deskList;

  TimelineEngine(this.deskList);

  List<Desk> sort() {
    deskList.sort(((a, b) => a.newTime!.hour.compareTo(b.newTime!.hour)));
    return deskList;
  }
}
