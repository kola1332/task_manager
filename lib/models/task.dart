import 'package:flutter/material.dart';
import 'package:task_manager/constants/colors.dart';

class Task {
  IconData? iconData;
  String? title;
  Color? bgColor;
  Color? iconColor;
  Color? btnColor;
  int? left;
  int? done;
  List<Map<String, dynamic>>? desc;
  bool isLast;
  Task(
      {this.iconData,
      this.title,
      this.bgColor,
      this.iconColor,
      this.btnColor,
      this.left,
      this.done,
      this.desc,
      this.isLast = false});
      
  static List<Task> generateTasks() {
    return [
      Task(
          iconData: Icons.person_rounded,
          title: 'Personal',
          bgColor: kYellowLight,
          iconColor: kYellowDark,
          btnColor: kYellow,
          left: 3,
          done: 1,
          desc: [
            {
              'time': '9:00',
              'title': 'Go for a walk with dog',
              'slot': '9:00 - 10:00',
              'tlColor': kRedDark,
              'bgColor': kRedLight,
            },
            {
              'time': '10:00',
              'title': 'Shot on Dribble',
              'slot': '10:00 - 12:00',
              'tlColor': kBlueDark,
              'bgColor': kBlueLight,
            },
            {
              'time': '11:00',
              'title': '',
              'slot': '',
              'tlColor': kBlueDark,
              'bgColor': kBlueLight,
            },
            {
              'time': '12:00',
              'title': '',
              'slot': '',
              'tlColor': Colors.grey.withOpacity(0.3),
            },
            {
              'time': '13:00',
              'title': 'Call with client',
              'slot': '13:00 - 14:00',
              'tlColor': kYellowDark,
              'bgColor': kYellowLight,
            },
            {
              'time': '14:00',
              'title': '',
              'slot': '',
              'tlColor': Colors.grey.withOpacity(0.3),
            },
            {
              'time': '15:00',
              'title': '',
              'slot': '',
              'tlColor': Colors.grey.withOpacity(0.3),
            },
          ]),
      Task(
        iconData: Icons.cases_rounded,
        title: 'Work',
        bgColor: kRedLight,
        iconColor: kRedDark,
        btnColor: kRed,
        left: 0,
        done: 0,
      ),
      Task(
        iconData: Icons.favorite_rounded,
        title: 'Health',
        bgColor: kBlueLight,
        iconColor: kBlueDark,
        btnColor: kBlue,
        left: 0,
        done: 0,
      ),
      Task(isLast: true),
    ];
  }
}
