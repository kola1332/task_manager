// import 'package:flutter/material.dart';
import 'package:task_manager/models/task.dart';

class TimelineEngine {
  List<Desk> deskList;

  TimelineEngine(this.deskList);

  List<Desk> sort() {
    // TimeOfDay? timeMin;
    // TimeOfDay? timeMax;
    // for (var element in deskList) {
    //   timeMin ??= element.newTime!;
    //   timeMax ??= element.newTime!;
    //   if (element.newTime!.hour >= timeMax.hour) {
    //     timeMax = element.newTime!;
    //   }
    //   if (element.newTime!.hour <= timeMin.hour) {
    //     timeMin = element.newTime!;
    //   }
    // }
    // print('*');
    // for (var a in deskList) {
    //   print(a.newTime);
    // }

    deskList.sort(((a, b) => a.newTime!.hour.compareTo(b.newTime!.hour)));
    return deskList;

    // print('#');
    // for (var a in deskList) {
    //   print(a.newTime);
    // }

    // print (' \n[$timeMin - $timeMax]'); // ? del
  }
}
