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
  List<Desk>? desc;
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
            Desk(
              time: '9:00',
              newTime: const TimeOfDay(hour: 4, minute: 0),
              title: 'Go for a walk with dog',
              slot: '9:00 - 10:00',
              tlColor: kRedDark,
              bgColor: kRedLight,
            ),
            Desk(
              time: '10:00',
              newTime: const TimeOfDay(hour: 10, minute: 0),
              title: 'Shot on Dribble',
              slot: '9:00 - 10:00',
              tlColor: kBlueDark,
              bgColor: kBlueLight,
            ),
            // Desk(
            //   time: '11:00',
            //   newTime: const TimeOfDay(hour: 8, minute: 0),
            //   tlColor: kBlueDark,
            //   bgColor: kBlueLight,
            // ),
            // Desk(
            //   time: '12:00',
            //   newTime: const TimeOfDay(hour: 2, minute: 0),
            // ),
            Desk(
              time: '13:00',
              newTime: const TimeOfDay(hour: 13, minute: 0),
              title: 'Call with client',
              slot: '13:00 - 14:00',
              tlColor: kYellowDark,
              bgColor: kYellowLight,
            ),
            // Desk(
            //   time: '14:00',
            //   newTime: const TimeOfDay(hour: 1, minute: 0),
            // ),
            // Desk(
            //   time: '15:00',
            //   newTime: const TimeOfDay(hour: 15, minute: 0),
            // ),
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

class Desk {
  String time;
  TimeOfDay? newTime;
  String title;
  String? slot;
  Color? bgColor;
  Color? tlColor;
  String? chap;

  Desk({
    required this.time,
    this.tlColor,
    this.bgColor,
    required this.title,
    this.slot,
    this.chap,
    this.newTime,
  });
}
